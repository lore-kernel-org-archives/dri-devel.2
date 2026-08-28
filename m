Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55BC61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2252A10F315;
	Fri, 28 Aug 2026 09:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="YqRQM4WY";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M2UoWwe+";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B364210F315
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:18:18 +0000 (UTC)
X-UUID: 6630fe54a2c111f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=p6fi0zQ6bAsFHDSK1BtxhKGSrpssODRPOaqsf9QHhpo=; 
 b=YqRQM4WY/ftReq18b2LKrrxyj0L8V4XA1yqSva0lAbAfJIdZt8y3lg2UD7hpuSD+dUZyE/XovBuw6bcVIC6kKMivYKX0iOsZ0sL3McfPUTpUfRshTqpP5rPNrcX5cZJHKvWiZebFt+lUC7/T8pAnFx9KbQbwl8wSKAAq++kZAnk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:7fa979ff-1319-4948-962b-e0f00f0efe58, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:58f130f2-6b5d-4016-ba8d-9f799a78b7e4,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|83|102|110|111|836|865|888|898,TC:-5,Con
 tent:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
 OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6630fe54a2c111f18dc8c9802ae25ab1-20260828
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1318720537; Fri, 28 Aug 2026 17:18:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 17:18:14 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 17:18:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwBuUArGHYYTFwpzc29t4nCVPi4Nk8cHhJOGQP6CsBN0sIGW26T7dd0bfnSyk9vvmsFiV1DJ65Omd8ZK/sq0jrXjIg3e7lWX3amFrKz9WmSdd2CmwN0+n5H7P0rgO9t8VwwFQgu1SVFx7zlQdQMxBw76x9EQhrHPLWWRNdWaOAcXY3SJ8mV9ZYIIOt4cQLTQQbPDOzUiMt94WrOaCVTd7WRjKjJbWNEzZyZzuhHqdG10U9V2dEv8DNiSLWojnJeVvdzcN7D0QcwV06to1eZ+ABww0MaeMERbTFIc++fP+NxOLUH+4BK1uFBoLT5qzRxerP4qFIEbSPpAZ3kLUnCCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6fi0zQ6bAsFHDSK1BtxhKGSrpssODRPOaqsf9QHhpo=;
 b=IPeXOSq7JSAAGDV39Ithos66EQpWGBVUHx6Xd1go4qPo32W8GtaDKhH9N8UcOs0HadtafjVVGSjr9rJOGHxJkzvySpZV0gW4UikVTVsWJaZQOyfSHYwfY1pptwwAuuyWLMy1IaxqC8HiSo+RLLwGyk9r5acKOReM+VXabk827VxUWfntOO3CnUw1C3BkopbKAFk3bqFqquN+nNbfWd576mJZZhuuMiyHLNSVZDhFEPyRTea/JBcKaz340C1xWIGe+wKQXx5i8UY6bqSzbhzv1e2DOfv+kHaX3+IfSqlspDjSP5+Z7QpUr0PQT5rX8+9d5Aw0J9CDyq71FCeNTEgneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6fi0zQ6bAsFHDSK1BtxhKGSrpssODRPOaqsf9QHhpo=;
 b=M2UoWwe+Om4SqM4TMoGYEgBlLSzFrknsS/4JPN6b7TcuiL7BDGAAufGz5ktPbUVaBlI28hSd9IE6OdX2iuFbu6DLRM60WOuX/XeZJhh51u0rVUv/GdgcLfVNyqT3LzvCqWOsncdrPMbT6njAfK7UKzEWNs5eOUdMJuuw0CCh01s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUYPR03MB10581.apcprd03.prod.outlook.com (2603:1096:d10:77::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:18:10 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:18:10 +0000
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
Subject: Re: [PATCH v2 05/46] drm/mediatek: Add missing component types in
 mtk_ddp_comp_type
Thread-Topic: [PATCH v2 05/46] drm/mediatek: Add missing component types in
 mtk_ddp_comp_type
Thread-Index: AQHdE4ZPaBgIYl2sEES0txsmIICu+LazdTuA
Date: Fri, 28 Aug 2026 09:18:09 +0000
Message-ID: <15395bc95ab90a67d2737580b46579a7f0cff65a.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-6-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUYPR03MB10581:EE_
x-ms-office365-filtering-correlation-id: 67f32055-b093-4b1b-83c7-08df04e5474d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|42112799006|366016|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: OfSo1lj0hj1H9yfiG68/WLNOE8ByAf5Vm1LRLYO1hVXP81UfDQoYvlqIaVz8HnPoPwJuLv9qtX9M1I53K32QvsyHPrBni9yO5MdO4SNZa4+vsPHEij+5Nb7zMWx5ogfVat8wt5W6KOUtWgT00sTKyIQKhJ7dgYgf37MKznitDAMk6u27Y54KCyXcz2nv9fsApS+b1HhpxMfhvXZ67Wrx+rap+e8B+QO78l+lAhX4Tw1YeJQ6npw7T/zp3zvbCwqJEJFJ4f5ucCoBxZW9JeXPrQo/o85DlpMj2z0FZNrhnCjnSqFkZ1lDzdXbEF2HeuXxi5Ya9NmH9OKkq5JjK7A/xc5pD+FWvPfxPORyjStET74Tt+hA2VAHvpPO3DIEipizfWr9LGzungDfHblVDxLCz+hpYNgkTDfDymXcCH833QWZKC8aIY2F0u5xRM9M8MhmlOxT9n4hyyx2ROnMMIBfNhlQ/kDEyImZTfcLCAeRMZCETcyYafxZX+OwmbTEx0oaR9ONrYrIpJaEqjMVhI+4jxskid1pZUFBovRqml9CKEbwPvUhRn4Tyh53YO1O4IAHOpXJCXqzLI6HDEEuQfllB2AAGp0+iCIng7FmnjmDAqvSmLKDUYE1kPiJ65eKR1vtP7oZ47aLiVjBKwlQcdwFZBx8pp0LBFoetPsazBOz0mY8MrX4f5GNEAiwfawj9ATVAyPU+nse3PQA01wlR1cqIoiny7KTdeIiWkZ/50gKaCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(42112799006)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkVrT2pTMWEvSk9GVVdvenZTS3dXVTQ0UzQydTFhMGdkNFRzZDVUYlU1Q1Rw?=
 =?utf-8?B?U3FBVjVKa0YzcWRvWE81SjN3T1BpVjFuTzZ5cy9lakEvNU5OZVlqVUhkRzJ3?=
 =?utf-8?B?QkZiUGV1R21BV0JCY08vckhkdXcwM25wL2RQMWdYQUhRcTEyVlN0MEVsUkpX?=
 =?utf-8?B?em5aMUJNbnNpNnFoNmJYWXBRTEVyNXZtMVZZRUF5NmJ3KzR1aWgwbHcrbG51?=
 =?utf-8?B?TWZNUFZsNjRGZmJCUDZCN3lKcGcxTmRvL3NsWHFJanZHR3FLYkdnZ3VSRVUx?=
 =?utf-8?B?TGc2Y2dSdWZvNjAvZWhla2Y1dk9NU0xZSm5zMDFQSWp0WldldEh3TmhkSENi?=
 =?utf-8?B?cnpremlXS0dHOEVLY0VUYStsaVUvWEpDSUcxMjJtNk8xN3BRMUxnWURIZ0Rt?=
 =?utf-8?B?aDFuTFRVZDNKdWk4VkhOWTZRcm14UXV2TmNoYWJXODVjY1ZieVE4ekpYNDZW?=
 =?utf-8?B?dm5OTWFrTTcvdnhndS9IWGZNV0VPNjRYd3BVMzJwbWpPN2lYZGZZRTRObzdx?=
 =?utf-8?B?aWR2aW5kdG8vMmlOOHJxeXpzL2VDWUwxalNXdFBpV2VGMjVzVnUwejNRRFFz?=
 =?utf-8?B?VG9PWFA1NWY0M3Rja0NBYzNoQzJPQ1J2ZWdUaVNyZUZuQjYwSUdvR2hIZnk0?=
 =?utf-8?B?K0xSV3JWT3k1ZUxhUjBkUHJETHZjeVZTUDZsTUE4Y2dyMWpGUVZFWkVKTUN2?=
 =?utf-8?B?OGtRemExVjFKRitVeFF0VTJSamNzT3ZlKytmR1hDZ3VuZTJLVW9IdW1BMUhC?=
 =?utf-8?B?c0NnT0IvZ0tYWHNTQnhsN2dDTG1PenB4Y0c5Y2pQa28wZWlySjVSK1c1SGVL?=
 =?utf-8?B?aUFlbnRMVHNjVE5QQjJ5RkVUbSs5aUxyZ2RaNWxTVkdGQnVkSVVnTEhGKy9k?=
 =?utf-8?B?WGJKUE5QTmhGbzJQVGQ3cnZ1WHZyc0haVjZlZnZSQytiNWV3TncxdFFTbUhY?=
 =?utf-8?B?YjdEV2YwVUhiY0IwWlZTUFJoNWRqSGJEQ0JkNUw2cnRLeWt1NS9CdVB4bnpC?=
 =?utf-8?B?RUdPZnNVUTFmSEVna1l1ejFkdmFjbmV0MGR4TXZmTU9FL1FGL1JrRzcwd3cv?=
 =?utf-8?B?WDhxTEpxMSs4SjM5MVgrVnpvN21vbXN0My9jeDA2UVhac1EwcGRLMnFJallX?=
 =?utf-8?B?b2IvZjllc1BEZFJHMU81cTdrZllWRS9zM2Vma3hCNVFTaStRVUxsVGxUZGVa?=
 =?utf-8?B?Z1FKTEU4ZFpLYnZ3Zk9pejhVdkpBYkdOS0NIaHZFaHRvM0lkaUZCam9FZ3NB?=
 =?utf-8?B?RTJEZFlzc2lLSm50aWU0WElUdXNEYUJXYjUwNTdFNitBOVY2N2gwSEF2TEhz?=
 =?utf-8?B?UWVwRW1kSkNmOERIdHJnUWcyMzU1ODhBdm9rbEV0SDRoTFJuUlNIRUs1VFNh?=
 =?utf-8?B?YWpob3A3blI0QjlDWk83VjZIai9iQ1BkeDlLbEV2VVJyWEVqQjFnK2kxckxo?=
 =?utf-8?B?d2FCa1RpWmNrckRtNXJ1eGZuV1lSTktPTVNNak9wOEtUZi84czF0NmZuczVJ?=
 =?utf-8?B?V1U0Wk1KeC8wZFcxYmFQZGxCSmltcEhudXhQZEc4YVNhMEUwdEJLWHR5cEU3?=
 =?utf-8?B?dTBwak1TNCtKY2FxQjZtL2x3aEl4V0JoUzhtaWh1U0g4b0IzcWVxYTdUd1hU?=
 =?utf-8?B?TnFWWFJFem5nRHoxdENBTjRJcmdycnJ1TUc5cGJLd1EyeGo2RTZGOVVQTENZ?=
 =?utf-8?B?WHhRRkN4Q0VDLzdNZU4xbVNKVkR3bkJZd0RwVzlaR29haVBqK1VuVEVCOVZ0?=
 =?utf-8?B?bTRDRi9KWkcxUGhKeHg0ekRhemZFWkhaN09qV25XUVlGNFQzSDdjdmFYbTU0?=
 =?utf-8?B?MTRJaExaM1FFa3NpRHVCMzlVSmwrRnljc3ZUTVk1b2tsd2VqbndrQU1OMytU?=
 =?utf-8?B?dTdhLzdIRmV2WjM5a3QxMzE2c3JucGJ2S1haQjBEYXJZdTJkM3RXL2xkU2Uv?=
 =?utf-8?B?U3JrTkc5NmV2MGhhTXhuWU1majQ5SS9zQUNqVmlDTzhseGxPTmlaWUd3Y2lk?=
 =?utf-8?B?NjNnSEcxQWVidk8ya09vdVAvaFY1a2lBeGxhQVhCNVBvUUFUWU9HZzJ5Ui9S?=
 =?utf-8?B?VW03MStqR0JjMEtlUStOcERiU2FVUi93TzBlK3lKdDlaU2h4QmdRMFlPYWFW?=
 =?utf-8?B?VG5mblNqMTV4UmtzOFdienBsR1ZIWm16Z3hYS2dXWm4reDdaWUNSK245U2Nt?=
 =?utf-8?B?cVptaDlDRndOa1pvNUNsUlEvQUVBQjhRQ3o4cUp3Tk5qUjJjRWo3UlhOMlQz?=
 =?utf-8?B?VEs4ejJnRlY3TlBWOXQraVdHWmlHZCsrUE9kV0pWUWozdU43MHNIK2Vua2ND?=
 =?utf-8?B?NEtNMldiaXdaZnpyZmplSUt6MndSZkE0eFI4MklOU1ZOUHFXRG1oQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4E702327C49424DA57A0E989ECDDBD7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uE/oBua1Dm17ABQooFjUWFjxr6b4nCxU/ELH8CdnhY3kqz6DoPZb17/KPaAsgOjLWwTckXgh4QEhzWKYeo3ADtRZexSShUuXYWrDTW0bdeIg5PvdqzLnWN4afvPH0uzOYutiN3qNF5uKtbDWW/CiJBibhuYl7ZXoPCZrzuP7uqE6DRUoNmH2XqPTovLAwzIV0CX2Ec6v/7bfWF92bUCxTZvCRdDAYv81f3UoobHLLyKafdD5MW7NcWj0Jr8C20iPHMRY5SL8gHqO3UUluxMFUfnyk0qiHHETSeyZHFESCRg5BPMxio7gZPa352FjTK+FPUwZywxg3fYpH+ee8xxWnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f32055-b093-4b1b-83c7-08df04e5474d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:18:10.0157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFV34XWla+gwG4lxjbVHjMRZ+NM/W2vg8McHkxW0DSobQKKQHBosx3ZJWrbbldkYSMxnIE1B/bWeUqbDzb36vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10581
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
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gdG8gcmVtb3ZlIHRoZSBtdGtfZGRwX2NvbXBf
aWQgZW51bWVyYXRpb24sIGFkZCB0aGUNCj4gbWlzc2luZyBjb21wb25lbnQgdHlwZXMgRVRIRFJf
TUlYRVIsIFBBRERJTkcgYW5kIE1EUF9SRE1BIGluIHRoZQ0KPiBtdGtfZGRwX2NvbXBfdHlwZSBl
bnVtZXJhdGlvbi4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9n
aW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo=
