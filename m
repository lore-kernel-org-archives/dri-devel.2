Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12EEC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8B210E8F0;
	Tue, 25 Aug 2026 07:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="NA12GFe9";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AHxl6WQF";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56D10E8F0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:52:58 +0000 (UTC)
X-UUID: fad1aa6ea05911f1b1788b6acf885367-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=N8K0PsV4HFV/Y5fHoe1O9SmI0VQKZz+Clex3ZZl8PJQ=; 
 b=NA12GFe9NCN05tgYAEBDtKy5uS5TVohiJRisUqacyjiRgnpqbhzqtC8D5wMBHkCGU1kYB9vN3NvsYrwd4GSwYZjHTU1Gz+45J2ZOkMvNnNk674rVOIsq8EcJCNp4WhKMq+zxyXLeLJTNBAoJKx2StdYw1IbRcLCzvwsC3JidFNE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:be812ac6-bccf-4c50-81a5-3d646e13f1bc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:eb8ad6e2-71f1-405e-92eb-6802d6af74fd,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fad1aa6ea05911f1b1788b6acf885367-20260825
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 628409848; Tue, 25 Aug 2026 15:52:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 15:52:53 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 15:52:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNA4Zwa23u55UyOwKQejagHivG3Ti1i5X/Hghnhnu44kRhv9wgD4NBR/8NG13XfhKtyQEh3DfessyHoMcuh+ZLi2gqs4Da3TMUM/n29e+Gc70RUP+2Ymzn0ttPxe2f0xd2ewegVxRlcncUBoPB9lLe7R5cyT5wf5Yt0l0s+uLAZLMW2aj/48pMCPAU2M/60sDcgI4vPLGVHXuOMyU6IQEIrWX5jsdF5wMT07X7v0bD+RYfp4NN/sylyp9qvPy3otiO85ePd86AjcigoxjR/5wzqc/hnBms9KH7OvPMm4he3PxjwT8iuKecBUTKshpj94k6IhziuRcpSaIaUzvxmyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8K0PsV4HFV/Y5fHoe1O9SmI0VQKZz+Clex3ZZl8PJQ=;
 b=iCT1yiu1XNy5GlgrAK2klMDqUbUYNsmrA7uBO3e7Uq+DlJsJw/2aoZjPz8/zfjRrasJilUZ5tvCRmyjabN00mouN7uN18sUo+4eYDoqfU4yEhnnKO7aYR59FC8XUUIvjuv1hlwImYvsPfSYbTresijnsNJXFC4fHyiQEocfpT++io6bJRLhim95KAMMYKRAkmNofglWaoqnFIW5pzLvHKT0GEJYwqtZ1Ksu1lKjNuPJZsWZLq7YvyX2rathAmqhFjBmol89w7BOepBCUSMohf/5G9q98909ptiQrJb4fC6GkRp9ua7BI13C7Fy6tW9y30nByqMDi3m39KcuGsRqSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8K0PsV4HFV/Y5fHoe1O9SmI0VQKZz+Clex3ZZl8PJQ=;
 b=AHxl6WQF7++I/yH43zwALSbahrYIOCkkT0rmOb9Wcdqnsnrs1XTzdplSlOOUYa3/+y/1Rw5CIsQaYMrg97hIVJSht5i76GyepH8PqKX72il/7OyTaNutpXYSY4HYqypz621YIHnXgHsir+OVgQTsTHh6t2VT533FH0c9wMl58j0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SE3PR03MB10088.apcprd03.prod.outlook.com (2603:1096:101:334::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:52:46 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:52:46 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "seanwascoding@gmail.com" <seanwascoding@gmail.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] drm/mediatek: mtk_dsi: Open-code
 drm_simple_encoder_init()
Thread-Topic: [PATCH v1] drm/mediatek: mtk_dsi: Open-code
 drm_simple_encoder_init()
Thread-Index: AQHdK00Ddhigr/hf7EqOIaa5XQBnpLaudtOA
Date: Tue, 25 Aug 2026 07:52:46 +0000
Message-ID: <17d9f8124696fe4f0f625ebc4360574e6e6179c6.camel@mediatek.com>
References: <20260813175517.156893-1-seanwascoding@gmail.com>
In-Reply-To: <20260813175517.156893-1-seanwascoding@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SE3PR03MB10088:EE_
x-ms-office365-filtering-correlation-id: f9726ca8-861d-42a0-9f51-08df027dda03
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|42112799006|1800799024|23010399003|10067099003|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: HhCMkFEL3srdvTG3E0/ZVo/zgLuuCT2lR3mw8ZndKKzo4nkBOQE8TsFUtLCFIGDXGK6r7oJhQoZRH8/BSkOiycmHNcTzh/qxaDZ+7u/dzulZp7lUZRZfsmqgYlsFZeeM/15eOISYAFbgdJ6fTKFzxID0LWAJkrSnnNHWMMt0A1DmkLg0z1U9fXCLq6rS3Ygzja3JIIVYAD9l3wjCkcek1bqjzc3pM8grFbZpYQuPQ2ViwbxB3wcUBR1ib+KdlHvItK78Qrd0B7eAeZq8iQBMk7svlxBEewbxjn53liaS7GJcmfUIyPkEtzWYxmHpd3ewHCG3VaOK0w8F/SifVijk542unc4u0IvJ27tyxJ8Mfhle0+bEAPluTx+hKp205y7GqjJNlOYSLvxYlBuZPtJOF35sryuTqWUbrX6s1LC50/J9UVCJlVNwwvUVicNC2z5YKxPFltY2oIO56EF4E78wNIAtCZXmuulxqRtZyDa0p/C5/QdSaWJq40a7rcOIsW1aFOTQX3IWldyrMNtwmskb600QgsY7uZTs1YC9hKQ853C616aooZ38GVlox26QN9ZthDqJToUq2E32JfCs3fh0PSLxLYNBHyYgSjlfe3Nkuku8rqF3F/LOCmkMbYGxA4AUIcMEmbO2sSSsm7bRWhwdKwpjFcXQQFUpb8sGzvqxQndJvrVbI0DLmUOaoDoa4bQKyzL+vG30/cZRvNSPGIZlC1NADjhtkTq1Lx3Xt/y2OSM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(42112799006)(1800799024)(23010399003)(10067099003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBWM3JZY0dlb3dSYk0rcmRUNUNjY1BaeWg2RkJldDdFRVFWaUtLaHhoYlpT?=
 =?utf-8?B?bkhUc1JNUytTREpRbXZaUFVZWnI2aVpzMmljSzYzYmZ2RHA2YUkyZmRUWEl4?=
 =?utf-8?B?WnhXc1QraG8yRnBBQ0dmZE1nRWhOVUhFZ1pJNFc0NWJ4UkJKMk9xdVI3NkxY?=
 =?utf-8?B?dm9tbi9tYlBzOHRYMVl2TGJpM0lDR0l3RDU4MlN5WkdZeFhDQzMwOWVELzdM?=
 =?utf-8?B?NkVzSDJOb0pUZ2hxOG43RUdHSU1MUUlnZGVESWJnVlNxTVR3R3dYSVBBQUhM?=
 =?utf-8?B?SHhsMDgycFFmNWhGalNwOWIyYlV1RjNBbTlnVzNJbFhOeGRHSW1uM3lrcHE2?=
 =?utf-8?B?UFhZVjZLdkZyVWVqS0ZlM0JnQ3AzdzVyZDVzSGtDMEVNVWRKS0JWU1lkZnc2?=
 =?utf-8?B?Q1BucGZEME9JVUJ5cHMwM1dqdzdmMnBZTVdwd2YyZVU0Qkx2VTMzWHhKc2hW?=
 =?utf-8?B?Zmt0cVM5VEtycVhwV1M1b1J2NjlpNS9mU29KdVNpejIxbVBiNW5BUTUxU1NX?=
 =?utf-8?B?SzZXY3RqS2FkNm55cWtKWlhISHVUNEVZWXJGamJYR1REczNRaTdnNGdVd1NQ?=
 =?utf-8?B?WElTZWo3NEM4bmxKTFJsbGU3MG1IUTdmM0JIeTVQelo4V0lTNUhoYlVXc1l0?=
 =?utf-8?B?QkpEUVJQMFk4U2o0dWZibGlUS040QmlZcGYzaVl3SHorNHd2MnpxdlBkcjZv?=
 =?utf-8?B?VzhzSWZOYTl4ZHVxekVyWlRVanBLRnZsaUJ5bFBMU3cyUWM3bEMya0MxVjI3?=
 =?utf-8?B?Ym9kRlpmbGM2TlBmQUl4TmxPdm4yd2RIRmhPdUp5M1NVRWp4WE1lR1NlQW5V?=
 =?utf-8?B?UlJqRkRQSDFwNTJpNE1MMTEzN3N1bW5vYkFCZlpoUzdTY3NveE1Lc1ZLdVFX?=
 =?utf-8?B?SkJQRDFqZlhXQXNIRmgwaGFKaTlTQ2UvcTVSNjFzNDU4ZjI0d3NCNDFsSGs1?=
 =?utf-8?B?cHJHWG52a2F4aTg4bWliNWFsNFR5OSswbUdMQ0Jnby9qYWF5RjhwdFRBTE5h?=
 =?utf-8?B?RjZ4UllqaXNtV2xmZFNWalB0WE1wRmsvWWpTY0MwUnFaaEFiT1V5MStIVkZ3?=
 =?utf-8?B?RktOR0dFcW9Ra3hXTVQ1YXpxNUNJNXFoWWM1dkpwZFpqMU5DWmxlTjBRMnRC?=
 =?utf-8?B?K0hlZncwNnI0ZGI1N2xBZmFBYzFxZnFjeGxOZWVtRjNyWEVGY01JdFUxcmtx?=
 =?utf-8?B?eStDaEVrTHN1SnhIbHAvVXBONVZDZTZvcERjVU4wVkdEbFlJdy9JKzV2OUcz?=
 =?utf-8?B?andZMUtGMHNBRmNnWExZNGcrdjFjaEV1cnljTUNMTENyLzdkSElLR1pEK0Qx?=
 =?utf-8?B?STJHZW1lclZYa0thRnIzR1NRalpXc1JZU25zZExTUnkxNkJRakhwZEdOaUtH?=
 =?utf-8?B?TGN2cURpb3k5ZUdLN2hjc1JBYW9HZ3ZOUmhGdUgza2sxbWt6K1k0QnZLbVlB?=
 =?utf-8?B?MG5DUFZFZUQzZDVoRW15NXM3empuaCtjdVhQQTY4UFNjR2MvN2JKMzlnOGFS?=
 =?utf-8?B?ektYZUljMmlwNW13eVdONUF4eVNiTWhhN1lVOHpkS0hocU00UWYvKzFrTWNC?=
 =?utf-8?B?NVBQZlQ3QmZ4a09Ua2c4RmlmS3dhcFh0SjNlNXMvRUtEelkxZ2t1aE5GelNx?=
 =?utf-8?B?MWpZWnJhWFUzcGF0SUh5cVgzVFBUTVN0VmZrT1huN0s4NUhLcE1qSk5UbGRD?=
 =?utf-8?B?NmlIZEFnalNDUVBncmZSeGtTZFliUnZzUXZvUjcvUTVLYXNpeTFtVVBod1Zm?=
 =?utf-8?B?R0lKNkw0M041aE56WEU4YXZIbGNkd3ZvR3NLUzVBVDRmaHFJS3duVGdMaHJi?=
 =?utf-8?B?ZUdzUjNQc1Y5VFRQNjVWcFNkeUhHY2ppQ0JBb3Z6M2owZXlKSnA4ZVpwZHJF?=
 =?utf-8?B?T3NWcThUNlBidVJKU3VwbHJYQ3l4bXFGU1F6Y2hNUUhRSWU3cFFDbVA3Y0g3?=
 =?utf-8?B?Q1d4WlZFQW9FZkhCSXBCN3RsUERwdlFUdlprVG85NzJOQkJzcERLVk45R2t3?=
 =?utf-8?B?Y0NxU3A4T1M2dHJFQ3pRVW1HRXlNSnFPVWJLVEV4SUsveURSRk03WVl4TGYz?=
 =?utf-8?B?NmZ6NHA5MWxlY29VN0JFUmY0aXVvaE0rY3hLekNVOWpkVWlUMW9CeDl3aGtl?=
 =?utf-8?B?MHI5N2NXNWEwUFVsTXM4VXdBdkc0RDhkTXRCT3kzV2tTdlVMSVY0VndXbmVG?=
 =?utf-8?B?V3FOSkw4MDdzVmEvVkxzSmpCVlltbnVWeXc1aVJsS29WMVEvVFhveWdiTW9q?=
 =?utf-8?B?d1ZHZ1ZxOGxFYjFkR2RaRjU5bzh6OVF3R2kvL1g5amNwNFpLeE9iRDl5bm5Y?=
 =?utf-8?B?ZzF1blpDc2RmUXRkQ0NrUlJwRk9ON3dTN3J0UUswd0FHRE5Ua0N0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <468F87DE491066419C73DA29273F246C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VmcIMhqEdTVUVepHPVnLlQWx5d7HDR4x0WHIzdZm2n+5Agh2mI8o2ymIfAcxW0Y6k5K7cbOv+8Ml0c63Wkx+xT/jm1en6upYA0TtExiQGHPjJp8RqFsJeVZOGkJxrUIZLrqhxACtnC2TD4ldeu4nSxQxFWptqSdJW6eFRwHIohXpYkro+c6abp8W2sW+uPO4Ae1MP6nuWzZ0MKppM7vuKZ1lVuy6wx4epRBtsyuIBOGJI+OFjzUkA/wxGEBZjRilAcgC8rg6a8kNR7xRzrbkts+vLi+FpzTvmOet7rc3b6n1aSq9wZsp8yTI/LKhbKQrBbnkIE2wzVXP1AATLSAyyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9726ca8-861d-42a0-9f51-08df027dda03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 07:52:46.1674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQq5Mhoiy6rFIcwWbtUtoRBxBsaeWfIZR1qsyvW/cu43c6HVmIMKvcanlk4N1izSJ//eXwixc5hFwJX7VaPFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB10088
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

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDAxOjU1ICswODAwLCBTZWFuIENoYW5nIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IFRoZSBkcm1fc2ltcGxlX2VuY29kZXJfaW5pdCgpIGhlbHBlciBpcyBkZXByZWNh
dGVkIGJlY2F1c2UgaXQgYWRkcyBhbg0KPiBpbnRlcm1lZGlhdGUgYWJzdHJhY3Rpb24gbGF5ZXIg
dGhhdCBvbmx5IHdyYXBzIGRybV9lbmNvZGVyX2luaXQoKSB3aXRoDQo+IGFuIGVtcHR5IG9yIG1p
bmltYWwgZHJtX2VuY29kZXJfZnVuY3Mgc3RydWN0Lg0KPiANCj4gUmVwbGFjZSBkcm1fc2ltcGxl
X2VuY29kZXJfaW5pdCgpIHdpdGggZXhwbGljaXQgY2FsbHMgdG8gZHJtX2VuY29kZXJfaW5pdCgp
DQo+IGFuZCBkZWZpbmUgZHJpdmVyLXNwZWNpZmljIGRybV9lbmNvZGVyX2Z1bmNzIGNhcnJ5aW5n
IHRoZSBjbGVhbnVwIGNhbGxiYWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaGFuZyA8
c2Vhbndhc2NvZGluZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYyB8IDkgKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5j
DQo+IGluZGV4IDQ5ZGZjMGY4MjVjYi4uMjc2ZDU3Zjg0MDdiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCg0KUmVwbGFjZSANCg0KI2luY2x1ZGUgPGRybS9kcm1fc2ltcGxl
X2ttc19oZWxwZXIuaD4NCg0Kd2l0aA0KIA0KI2luY2x1ZGUgPGRybS9kcm1fZW5jb2Rlci5oPg0K
IA0KPiBAQCAtMjI2LDYgKzIyNiwxMCBAQCBzdHJ1Y3QgbXRrX2RzaSB7DQo+ICAgICAgICAgY29u
c3Qgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgKmRyaXZlcl9kYXRhOw0KPiAgfTsNCj4gDQo+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2Z1bmNzIG10a19kc2lfZW5jb2Rlcl9m
dW5jcyA9IHsNCj4gKyAgICAgICAuZGVzdHJveSA9IGRybV9lbmNvZGVyX2NsZWFudXAsDQo+ICt9
Ow0KPiArDQoNCkFsaWduIHRvIG10a19kcGkuYywgbW92ZSB0aGlzIGZ1bmN0aW9uIGp1c3QgYmVm
b3JlIG10a19kc2lfZGRwX3N0YXJ0KCkuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICBzdGF0aWMgaW5s
aW5lIHN0cnVjdCBtdGtfZHNpICpicmlkZ2VfdG9fZHNpKHN0cnVjdCBkcm1fYnJpZGdlICpiKQ0K
PiAgew0KPiAgICAgICAgIHJldHVybiBjb250YWluZXJfb2YoYiwgc3RydWN0IG10a19kc2ksIGJy
aWRnZSk7DQo+IEBAIC05MTgsOCArOTIyLDkgQEAgc3RhdGljIGludCBtdGtfZHNpX2VuY29kZXJf
aW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLCBzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0K
PiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAtICAgICAgIHJldCA9IGRybV9zaW1wbGVfZW5jb2Rl
cl9pbml0KGRybSwgJmRzaS0+ZW5jb2RlciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBEUk1fTU9ERV9FTkNPREVSX0RTSSk7DQo+ICsgICAgICAgcmV0ID0gZHJtX2Vu
Y29kZXJfaW5pdChkcm0sICZkc2ktPmVuY29kZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmbXRrX2RzaV9lbmNvZGVyX2Z1bmNzLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRFJNX01PREVfRU5DT0RFUl9EU0ksIE5VTEwpOw0KPiAgICAgICAgIGlmIChyZXQp
IHsNCj4gICAgICAgICAgICAgICAgIGRybV9lcnIoZHJtLCAiRmFpbGVkIHRvIGVuY29kZXIgaW5p
dCB0byBkcm1cbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gLS0NCj4gMi40
My4wDQo+IA0KPiANCg0K
