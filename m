Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECADCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F7610E2FC;
	Fri,  8 May 2026 08:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Tn22uZoB";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XXNpRczq";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A0410E2FC
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:25:27 +0000 (UTC)
X-UUID: 74d0e21a4ab711f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Z4tG/DeG+o9l2aKXwBrpvinR0jaHeIDIe2AOze6RrMM=; 
 b=Tn22uZoBz0AfP5nreGM8RPFuH244+UeM7QHMyVjJuocxOf3gvk50jhlZYhxudWylppWo2c0+z6q/f/y+cte8r2RHO60NPpzDE8/snx7uhQezCRCnqRYEoeNOCiYdOc2rNhqRQMPgWRR0vs24/gHbWjzghleGeLQqL9QerZSR87s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:988f5a9f-37b6-4d9a-a027-801006aa636f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:1e044c45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 74d0e21a4ab711f1a4e839cc21f16abe-20260508
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1745762387; Fri, 08 May 2026 16:25:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 16:25:21 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 16:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjQBIhGaaftz6cWqdbWsbvCmpqsGfSYWKe/7sgkJ2BCo45a8z6nNm4xTiDCjA1W4O5DmzjUuMah1ah2KNCsuu/3umTWr2EaQUGaAzoxNQ29XFeqZDi/UynLbXaDx/E0xq2taAqsdhHF8ZRM3oOncxPhjXSmFrFY18gmozboUTdaqhdKyuoc1vzpFIE+iH4PH+azS3AHuO/D+3QgEHKmSt+K8S/Mg9+Nofd1y5X+MTo5Bc+aV4CwVJwf7S3UMJsKfD3daKB72+2j/hwNmPxwBEjiJCwB93kr1Nj8WhAGMpcgY3AjGV4t53gZMlIcG00knEwOmvl5LQwKbFNXDWCHWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4tG/DeG+o9l2aKXwBrpvinR0jaHeIDIe2AOze6RrMM=;
 b=JqYQhq1Tll8KcBZAbRiWND2ZAW7SSqQl+ZppzIFqb60UytNEzk3tfC+XZsuwmdynnWKlnOSTbgOz8Qjz1/TXg8H3vOCp12a41z3iFkbpm+mQIvFpWs6geL34yQWUcGiXTwaSregI2M5RQOpLCKTnlukm8Oasp51ugJ+yveHoo0odsxVfM63MrNcM465zZtvO48NrLNdlw10iFcgrdyGs/fQbPV5201G6aZ2i51MEgk8zchM/R8MGhjPPcHi5l8QPhSdqAp7vANUlGcojzaErMQm0vOzIFocHiua/7B8TQH0SyilMi5PDjC/jciIvrpli+YchnbLXR0pJKMvT3tnO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4tG/DeG+o9l2aKXwBrpvinR0jaHeIDIe2AOze6RrMM=;
 b=XXNpRczqEJx1JGXBWdaTNnCickmLpvxUnnxVe4M+M09OlU/XWj1l3dcETW9GBi5k8GUwzOcryipFCbLrMKR7hx0D3thRhfkZo2xcvoE2f8tcOq+n0XbXDjlyLSepGVkTlNoQC4FjmQkV7DWO4QC1KaW+W5/7pTF2wj0MIBt8hd0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6430.apcprd03.prod.outlook.com (2603:1096:4:1c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 08:25:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 08:25:18 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "suryasaimadhu369@gmail.com" <suryasaimadhu369@gmail.com>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
Thread-Topic: [PATCH v2] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
Thread-Index: AQHc0JFti/hGESO5/kiM3dfKe3I5YbYD50OA
Date: Fri, 8 May 2026 08:25:17 +0000
Message-ID: <8bee5bc780319233c4e251b4a1129921216cc26b.camel@mediatek.com>
References: <20260420064544.266478-1-suryasaimadhu369@gmail.com>
In-Reply-To: <20260420064544.266478-1-suryasaimadhu369@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6430:EE_
x-ms-office365-filtering-correlation-id: ee89365c-6fed-48fd-52d2-08deacdb5657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: FFkUCKJwq++1lWxax96G0hKIeGynX/wIlsEKBDYxdd1XI8HRlIG9uhbbzJhrJnoRjqwGXm0GHlWO3m6cHiNM3l8ddF4bx0bLPduy4p1yJAs4M9rdWG+wo/kCQG0rY7cceaN5RG+O6l5RivO1hCjpZ12U58HSLtbOeST4bCHzxpD1xW+f5ceaCULF341Wy0BB1UFboNBR78Q7+l0F7y7NPjv8zJwQqYXI9w5ZBBVWtDyWh8is5RQfmZAMvGyePcMsd1ihJh0KQT0ae98QI/ipOiroU3DzDhEp7LlfmGbwvgauQIrTxe1nKqOzZ8/NCOCxeE/Lvir+vhzHNBZF7uEqpaxZJSdzNarvBa0YWHWGK47LIHM/VAlw6GOGU7AUqZMQJqhXfdGlJwRjza4oSLE1/H88M72XyFXioiaqWFDbqpAH+K8riNZQA3WOqeSTyXpPpm3wzNoEA2IgBeF+W/tZinlEM9Q3utCoMlvBGk1/oEXmVQraFWcTvCPD7M4Q7IGnXUCs/Z8SbJ2lPlyo9hCp1YS14ARnw/gkJNFmiLKOkbNnuZ9Do+8Md4jFCHi9iC5CLPkd2iuBC1kVSLruR6nZz4xLSRD8m9S1vbuTlhN7eFJR7yBtOFSqbOy1MlvkyZPiu/cpwPRtNN6OlqD5LWdwvzZhVQdnkfxedw8oWrGq3AkVAUtHXmvJcds2Eggt1TM1UI4LQB/hliVX8LnKDExe3YhES9pTeNuR4PwGh6bW++0RZ/PkIX4FMwlCpjo9GP0S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDYzdldRZDJobVYzQUNBWG83c0NHTVVmNFYzNkxqYWQ0YlZiWmJxU2RVWHJE?=
 =?utf-8?B?bXN0Y0RjOVdhNkw4TFE2T09CZldRSHRGVklaTENtRVVoQ1QyaW15NlJwS1Rx?=
 =?utf-8?B?NDIwelhtaytBMXljYWdwSGttZ1JzRmRXSUhRWXpZaFREVlpsRnQ2L0FMdG00?=
 =?utf-8?B?Q09RUC9aTHRyREo3Njl4UElSZ2NFZi9ZVFg2U2VBZWFhTnhtOVRjSXRmY2c3?=
 =?utf-8?B?ajB1SkNoWU54MzR3NEZhUzNiamdHWnFDWTgrdFVDTDBpNTVWQ2dsdlM5Rkhl?=
 =?utf-8?B?Y1JJeHdlUzhoU0RrWGp1SUtUL2xrcGtubGhyWWxWSkxROFZ1Z0ZHdUxwaUpP?=
 =?utf-8?B?ZUV0Ky9JUzJHT0IvbG01MklKYmREUFYzcnFRZGM5bUhQcGM4RnczZmxyRW1s?=
 =?utf-8?B?Mm9qS1Qvbk5Ia0VxWXV4QkdvM0tEcHB0VjNKM1JhakZKcHc4WG5xb1l2aldN?=
 =?utf-8?B?NDNVTWxNdWFERFZsK0hORHdZbmJOckg4aElMZWl1cFFhb1M0WDhLaTFKckRO?=
 =?utf-8?B?N0hRVlVzZEIwS2lNWVJKQVFmeFFRNFF2Y3Q1T3NvWHJ6STEyK25oSlBlWnhC?=
 =?utf-8?B?b2crYm9MWDNXOWN6Y2pycEZ3VTRVaGNnRWJiMUdZc0xHcUVmVTNBSTlwZVA0?=
 =?utf-8?B?MTVwUVRaZHg2TWVvL3R4RHJMNmQwYUZ4N3RUclRvWVVZYzQ0OUFTbzdMU2Zv?=
 =?utf-8?B?U0F4QU41SGhSVUhKR2VoNTRDbDg0SDFBUG5mZktJelZaYmFXbmNGb3UyTkZa?=
 =?utf-8?B?MmZwdHRBYWVnUklGZWc5cVBpbHA1QWlsQkpxZGlNeVB1ZmNuZk9WV3N5cTNX?=
 =?utf-8?B?cGN6R3B4bkRoQzBTTHZCN1d4VGRHMVlTMktOR2VCaDg3K0VHUFdSaEovaTZy?=
 =?utf-8?B?T2xoZmU2dnpNLzFUbHFmOWVwNEFYSkVXYVhSYStTNWo2ZmM0Y2Juc2V5Kzdu?=
 =?utf-8?B?YndjTzQ3bzVidlV2YUlzdGhVY0Rxa1hxV0xvVUo1SGZReEozbEZxNUxINC8w?=
 =?utf-8?B?RmhlTmRPWWhJVG9yMkVDQ1p6S3hZaFAzTDZBZXZaMStiNTJlUTUyYnRDbXV0?=
 =?utf-8?B?THRDRGVMb0J2dkQ3NnovZFZzei9WdjdCcWNQTTN1VjFNdmxkQ2twSzlSU2p0?=
 =?utf-8?B?UWdaMjd6bHZtL3A3bFUrMFM1dTAvTFFnRVU1ZkdySUt1QXcyQnM1dU9hQzMw?=
 =?utf-8?B?M1pvMmxEMFduM2hXbSt6SDNnZm1KTzNET2kxdzd6R2RrZ3JwUUFJcXI4ZnBz?=
 =?utf-8?B?RVlqVlJicW05Y2xOOEFTSmFMN1FYNzFsSk83b2RKa2Q0YWE5YjN5TmxPbjFm?=
 =?utf-8?B?enNYbmJNcWt2c1JYNUZWYS9DVFBlS09DbUtTMVNjOExRbkpLWUNWUmhzZ0or?=
 =?utf-8?B?RHkxTnpvT0o5TWdxUzBtSUNTbGRIU3hpS21yUkxvcWQxNXBLOTU0OFpXMTV1?=
 =?utf-8?B?VVFxakxJUzRWd0RYRTNxRmdUek1NUlJ6NkhLZGdtKytSMjJLZnVrZGplK2lO?=
 =?utf-8?B?bjAvcG83RXh5YlhTUHFrRkVRZFlGVFFBU2hlUms4QmQ2SkN5b3FKWE1HRE9I?=
 =?utf-8?B?UlJNR0Fvb0ZTQU5rY0JYbFF5dDBuMm11Tm5CMlQ4Y0pRZlRlQmJSd1k2Zm1v?=
 =?utf-8?B?UTIyYjZPRElURHBhd29hL3dyUGJTRWwvNWVNR3Vac0pxMVlHdzR5TnhFd2ZO?=
 =?utf-8?B?L3hYREloNWtxcXJKQmtWUTF4VjA0bGRYOFhtV3FBbkZwZ2ZJYTV0RC9Fb1RY?=
 =?utf-8?B?NjEwaU1VRkVucjIrTUh1UjJ3cEx1RVVqYms4VEhrZWNBZjlHeEJSYytNK1pP?=
 =?utf-8?B?aUhVTE53MWlHNUNOMVk1T0RHSkZic3poQ1VTdjZabzFEN1F3SjZ3THgvTWZo?=
 =?utf-8?B?dUVzTHdENEhyWDZxbFpsMVdMNFZhamVIV1Y2MVVXOHFkYVZsZDE5VVdLRldF?=
 =?utf-8?B?b2V6Q3BWbnZVZkx2d1VReGloN1BqN2VmOHl3TFdQTUZMZmUzeGtLdk8rS2hZ?=
 =?utf-8?B?bGxIbnExOENtNGNEeDVhd1VKcDYxQ2p1RUc3WWhXUUQ1cTA4TVlOeGNtOXho?=
 =?utf-8?B?L0xjM0p4by9nQVVyY09pUEp6cksrd25Rem9jdzJGekJlNTV5WGwzWWQ3UCta?=
 =?utf-8?B?ejlrM2FsalY4Q2JPUEI4cHRGZUI1Tys0TmF5OTlTRWRJcU51RWhjMytML0VQ?=
 =?utf-8?B?cUgvdTdoZzQxbXhwUmR1SjhvZkVtbkpvYUY1YnVPdGZLM1A5ZExHY2JyRTd3?=
 =?utf-8?B?djNhV0xrZUEwMktLSFIwdlJ3TTBxQVkzOGlmbDh5UUZTdXdKUHpGaHhLOXNE?=
 =?utf-8?B?R3BESWlzb2MrUjhTQVY5ZnlwTlg2Z3hrNTNER2F6ZjdvOUZJcVl2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72204FE3EB3F62478F4A1EDB2835E672@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K9GTCeOE+4SY19xoIljZGUISSKIogkL9BvauL5rpOeGEfPMqbnzPKFzd2S+HepttN6J7e8A5CIfnhbIJxNS7G3/B4wk1aPAIM9WcIEOTogLUzv1pKJNhaoTwYD9YDUfecjJb/br+CHO6+6pouTPTKHVtGhWzs4IKrulVtBsy3wIJREt+B4Ax28NfgdNt0Vi12JsDoILKbPjlRrZ3LR2Y90iB2A8Attnrf2ElSi2lfG6BzVlxqGBprrZk2ZsmiDSTLdoqIKXXarwGOcluoaYvJgQcpnuFi9h/+8ORsACBx3MciENqfNVCYoTc3y1e40I0lpoT58amUtJqoKEGUljpiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee89365c-6fed-48fd-52d2-08deacdb5657
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 08:25:17.8491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWG73OcGVXnBJun8uRNx6DORXY9WhZ5fLmboe0p00FqscAYbBNNLHm8NOZpxky3noZnTgbxLwZsCiwDl7nvIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6430
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

T24gTW9uLCAyMDI2LTA0LTIwIGF0IDA2OjQ1ICswMDAwLCBzYWkgbWFkaHUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gVGhlIERSTV9FUlJPUigpIG1hY3JvIGlzIGRlcHJlY2F0ZWQgaW4gZmF2b3Igb2Yg
ZHJtX2VycigpIHdoaWNoDQo+IHByb3ZpZGVzIGRldmljZS1zcGVjaWZpYyBsb2dnaW5nLg0KPiAN
Cj4gUmVwbGFjZSBEUk1fRVJST1IoKSB3aXRoIGRybV9lcnIoKSBpbiB0aGUgTWVkaWF0ZWsgSERN
SSBicmlkZ2UNCj4gZHJpdmVyIGFuZCBwYXNzIHRoZSBkcm1fZGV2aWNlIHBvaW50ZXIgdmlhIGJy
aWRnZS0+ZGV2Lg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBzYWkgbWFkaHUgPHN1cnlhc2FpbWFkaHUzNjlAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19oZG1pLmMNCj4gaW5kZXggMWVhMjU5ODU0NzgwLi40ZGRjZGJmN2JjOGMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+IEBAIC05ODEsOCArOTgxLDggQEAg
c3RhdGljIGludCBtdGtfaGRtaV9icmlkZ2VfYXR0YWNoKHN0cnVjdCBkcm1fYnJpZGdlICpicmlk
Z2UsDQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+ICAgICAgICAgaWYgKCEoZmxhZ3MgJiBEUk1f
QlJJREdFX0FUVEFDSF9OT19DT05ORUNUT1IpKSB7DQo+IC0gICAgICAgICAgICAgICBEUk1fRVJS
T1IoIiVzOiBUaGUgZmxhZyBEUk1fQlJJREdFX0FUVEFDSF9OT19DT05ORUNUT1IgbXVzdCBiZSBz
dXBwbGllZFxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7DQo+ICsg
ICAgICAgICAgICAgICBkcm1fZXJyKGJyaWRnZS0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAiRFJNX0JSSURHRV9BVFRBQ0hfTk9fQ09OTkVDVE9SIG11c3QgYmUgc3VwcGxpZWRcbiIp
Ow0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgfQ0KPiANCj4g
LS0NCj4gMi4zNC4xDQo+IA0KDQo=
