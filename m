Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762D4C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40FD10E947;
	Tue, 25 Aug 2026 08:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="V4YaNNdy";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pfmJ7s7+";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1293610E947
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:06:42 +0000 (UTC)
X-UUID: e49915c8a05b11f18dc8c9802ae25ab1-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=3B6WvTRANiF9hjvuRIq3hbcS3PjAlPn3ukBM76gcT4w=; 
 b=V4YaNNdyU08H9MdNlZkF/UudFieCOdWb/m9mTMEfGHo2kT5k9uBB5VXIyFdRqZkSBG57KfHDnNrcmKxOV3qNIlkjfx99GTx435sr9YMWT3DgLM2paoUScc/IQG3+dWh4Xc5ZvMDiU1Td8LZ9MSqUgwG+79L9Lv+U7B0se8vgngw=;
X-CID-CACHE: Type:Local,Time:202608251552+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:20915107-5b54-44e7-ae55-b4490018f89c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:b50364fe-f4cb-4ad2-b022-e3ac6648bf25,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e49915c8a05b11f18dc8c9802ae25ab1-20260825
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2130787496; Tue, 25 Aug 2026 16:06:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 16:06:35 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 16:06:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0MF7PpP3r+epU4KcTXlO47W+gWRq66JCr10Zr/zZnCplqZEcjljIEyIxOJDOnOZrcycsS5XQn8Pvvl4+Oqxsun5aYO+TAYrFs7p6BjhmcsPuWTcfYfSU7U1Xz1JMWrqznbvIbrL35GpBqM+zTiYpaKi9yLrlSs8hEoBTSxOwozzndslul+NAp+cTqGzJ8acRdkUoCyrS9P3Vf+oqfRhIy2aamSTFkjRN2u+a5UA4hMYtcPIryRpQbgW1RK/HBr9D2/MiF7uqaP+bp+6TFgpiGvgI6BWbBjKTgC7TTDHGQsI1ncxXoekClqiJn4AzGodlr8n5qIHJLL2xsb3nNyhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B6WvTRANiF9hjvuRIq3hbcS3PjAlPn3ukBM76gcT4w=;
 b=baUPXqQnXhF/pByyXO6Y0t6tkK6QK7EbHdqTj9gdexeMNJKCz/Ws77cHsJBUOTpWHYnHAmDQ8055kKiirx6q8pTBgF/the1pXim2QEwr9GgQm9czCadlCfK01y/aFLEa0DDB2/wnAbFC4WpwGRA2S37i7vr6Vgk76eZI/J1UsQkX3XRWOBEmjewyyU1WvVOM9M3sxX5sX8Yv7DjmMjcVXcSl2sfarZhSFK948MABKqHZujZ9la30bmNKdwC6zR6Njp+XJXKqyNrNdmfHdektBqLoLAVwJ/94TjmWlUh6EkWmMq4uKlDTiW9kVhYne8lIqgPlYQ5IBPwzmKekVuUbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B6WvTRANiF9hjvuRIq3hbcS3PjAlPn3ukBM76gcT4w=;
 b=pfmJ7s7+oKvF7FoNaWjUP1miHinDYSek7BsJzsy4u39XaOI6UJRLDQbdaTK8bd6nqxiqlvS2xEGB1Z+mrYgspHKip/hY4eZyM1wA9ss9UL6UIxpWoHIcNfQxttrJkvzKIAfNdtIq7jHshAz4rfZrd9aQ9T9rgSVyT9Otop/ckGg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSNPR03MB9887.apcprd03.prod.outlook.com (2603:1096:604:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:06:32 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:06:32 +0000
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
Thread-Index: AQHdK00Ddhigr/hf7EqOIaa5XQBnpLaueq0A
Date: Tue, 25 Aug 2026 08:06:32 +0000
Message-ID: <dbd9a0904d89c2101afffbf302166bcf766e80d0.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSNPR03MB9887:EE_
x-ms-office365-filtering-correlation-id: 9f45266d-2aba-48e8-c045-08df027fc6c0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: YLhX3EdhTZoAloaJgoGFXSgP5bdKltGGuFgEqw6czsHAxeLaVcDUycfg873MR5Y6Mxt7rCkDKWiKkbEc2T6k7OOY+QR+FsbYCb6ILJ1hlA4Zvz/Js5qjDcjgM4/W+qAxulCit6OGkoqc5s2mHoi9sLZtSZ+B0hcaa0llxyJvt1IyE4S359eMpPg2ZnX/eSeCC1gnd7hWjTCLZf9CAkdU5memiVExZbcK/RQNdRxz8910BLg8dro2EXCfVE0iW/IInFk9q+oC7C48p9IIvLh/0Y3lTFnuJ7vxJnTdQEKD7SC0GJZqpH3CTstbSL3fr3mvE6bcoh9Mmc6gtCJkPfMmrZbo0jKwLE3kh6LFUksS4oS4F56UmvoO/Zbw7e0/Bjs14eGgM3SaTo2/tO5E3KH8NXbIKpCPzjXLpCq/bdWsZuJLeb/jLaNhPa6GZC7hr4yPSj7HvWcW2OVqHwH8xdgzPT+2rpKyNnj/loKLtBz5qxqxtxtqbCO+OdUlczpC/7rNgeX2SNfgF+IuHFrTAvBqHBAm6qkH6GrHDLXxHmBhD7LuXVmagy2xB82Na0R4hmA/NHNJ19xkLnoh+pOqBYmPsbZUoKEcqhE1ifD1+EuZLTxRtSp/TL4go9w3r0d/r23nUgVSGh8R3FmJ9C4ZEBIwhNa2YL6H4gR5bEJFZ/y6lKki1l32y+M1ShKhPcu3kN++fNcVva6OArtrhUW8RBgB5FQylZ1vPYICp+T0PQXBHI4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlhJMTU4c2RtM0poelZCbnVsRytpOWg4NXhSMVV1ZUNGV3hTTWR3NkE0UWdS?=
 =?utf-8?B?dkFLSWRQaGZRV3ZiTUI4MTk0Vnp5bXhrdExENEJ4dS9Tb2lHelJ3dkFHaDdZ?=
 =?utf-8?B?Q05ydGZ1RGFEd0ZvWW9rcjdicURIaEdZaFExUy9NcTA3Y291ZjJhamc4RnNv?=
 =?utf-8?B?c09OYm52Nm9wL0YyQ2FNZG9vOWVRTUpTWkxrWTRTQkFkVXlxaUdwOTRZQTJo?=
 =?utf-8?B?cHNQekJvb0IzOEdqaDByaTJveVFhS1NTc3l2Q1FOcmF5dGcweFV4MXg1Rnpu?=
 =?utf-8?B?azY0TVVkV0lxR3NZM2dwQUw0eFhqWmZua3FDR2hLZ0J1SXdiV05DVWlHbWdu?=
 =?utf-8?B?c2ZPYlI0Z2NDZTFUNWF3K2xRYlptRFl0Tnp1dSs4bHJ2Nmd2MjVDWk1oekhr?=
 =?utf-8?B?dFQ2Ykc3aXY4QUVaTU9tSDZSZ1VjU3RSU2dnTm8zVjByMmg4clBaeVlNcEti?=
 =?utf-8?B?OHpGSDBTTUZrQVNtLzBOdlErMmcyL3hQUWdWNU9IL0tPeCtXNWIzTUJrZFFn?=
 =?utf-8?B?RGRKbHZjSnhlU2FiTmJaRHpaTUJiYU5wbXIyaGtqeithRXoyeW96eGNZVU55?=
 =?utf-8?B?M3FGMTJXck1uMk54Qko2ckRJaU56a1l2cGVUYU1RbkJkQzhTMHZxZ1ZFM3Vm?=
 =?utf-8?B?cXlWR2I1RDgwd1p5cFpQb0tDN29YTkRKaHQ4TWhVZVN2OUFTcGd1OUFRYWFo?=
 =?utf-8?B?L2VlQTNQUXhMQ3pKeStqeGx4MHdUU2k2eFFkVHovcERDN3YxUXdzSmZjWkZz?=
 =?utf-8?B?ZkFEWmZEaUhNOTJZcDROWlA3N3hCTTN2Y2pDajMrUXFUWERET2dzWWFrYUZ3?=
 =?utf-8?B?cmRCVXdFWVRVYlEvYXFaMHRGOVhrNXRmOFZRb0cxYXlWMU54S05JNWllRHU3?=
 =?utf-8?B?VzFDbmZlMzBmeERGNUZKRHlPYlBCSmpYS090bFczQjlzKzkrYU1BUUVDNENQ?=
 =?utf-8?B?eGk1MjlqSFQzTGVBZDgxUE51RkNZUXNtSFlWWURiTlN0dkQrdnQwYSt4OUh0?=
 =?utf-8?B?dXJrOUhqVnBsRnF1ZTFPRGM1dEZidmVQTFVJMmVZSDlaRHZFbi84UWtmdlZG?=
 =?utf-8?B?ZjV3NzBOOGlnRXhmdm9CR3h3N2xjU3oxb0gzTHYzc0k4VlRaVThjc0UxNHBV?=
 =?utf-8?B?czdIZVFrdTJCYzZHbTRFTHJaclJ4Q1BJNDJkQWhVL2NxckZHdXFPZWd4eDNR?=
 =?utf-8?B?MERmSkNSWklRRFBkKzYvd0VGY3hLMllzdGJKNFBBMDFwZFpPZk56RFIvaDdU?=
 =?utf-8?B?TURYalJ4SCtCblpkQmxVbWc1NWQrdHFPZG82M240ZThWSVJ0QU9lVlg1VFFs?=
 =?utf-8?B?MlE5ejVDeGtiMTlqUVAwOXQrRFhDQUV0Z1RuenpYZmxTakRscjZ0dHlocHhq?=
 =?utf-8?B?c0hTci9xQ3k4TTQrS0tRQWpvWndVRmRlZHRIejZtc0FYZlQvMklHMXVsdXhE?=
 =?utf-8?B?RE1OT0VPRGNUYkh1YnFtZzgwcnVRRXFnZGVVWTBIc2dUd2ZZck9malFBZVVB?=
 =?utf-8?B?UmFEUmZ5WVYwb0ZrcThGNE8vNFpHb1VUeG15ZWhzeG9tdndyS0EvbHNMZzV0?=
 =?utf-8?B?Zmp1S082QTJzZHA0UFQwVnpIZDl2L3dURlB0WTdpSGdoZDg0OGU0VFdMeS9K?=
 =?utf-8?B?enF6bmZvcCt0emJVby95RjR1VXhVY3JRYTk4WHc5U1BrM2hDb2VQSk1NL21M?=
 =?utf-8?B?MUZVOUlTdTZFU3pjNHhDWHA2Q0h0M01rL2ZjSWw4Zldaeko1N1NMWDR4ai83?=
 =?utf-8?B?MGRxZ0NiMXRCdUJldnFwRlBQSlh1VXg3bXJobHdGcE96Mzh1QUdGTWg3czlC?=
 =?utf-8?B?VklTWjZyZmR3alc3M1VkUUJwSmkrT3FYNDVSWUQ4UDI4UXhMV2Z6eXlnWHVx?=
 =?utf-8?B?VjYraHVTTUs4Yy9aTTZXaXVvRzN1UzVBNnY5UFdQbjVvNTI5VCtBcE9YYk9L?=
 =?utf-8?B?MEgzL1VqcWZQUDFkZVdXd0JNS0E4QzVKdEJLdjB0WjdHNmNIK2s3LzFta3Zn?=
 =?utf-8?B?ZVcrUHZuNlJldU1icDA1L3F3Mk5VK3ZFYnBxL0JNMUpOTmtSK3hxVzF1YzlL?=
 =?utf-8?B?SFN2VURlT0FpT3V4ZFNEaE5pTkk1WDcwNFVIS1dVUU9zMlptc0dkR09WNHcz?=
 =?utf-8?B?Z3YxUWZGTG5PaVRWTENWbDQ1dmd4WW9XQ1lxQkk5V3JLT3h1VXg0Y2lNc1o1?=
 =?utf-8?B?dGxJTEI5SncrN05lZDNxa1QxS09HNnczWDgwanRBdmJUYkJYdUZueUFkeE82?=
 =?utf-8?B?YXY5UGpHbURoVFh6dnNOc0Zub0lCOENzR2ZNRFhDaVBHNER2VFVGZHlzbGhD?=
 =?utf-8?B?N29WRlo4cGRCRUFSNGJKYTNtcWtqUStGSmlDb2dLdmJmaGt1Qk9YUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <956CC19E38FC1B44AB6B18E5A7803530@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ykR9GIZwrWFnNPsMviuIaOcdF1ESoKp9bjIuJYGeqfR+6s9OC3P0BVl7NSUgCzH0AeCd1K7DkzKPnGMRq+Jqubs3LtCPLt1DNMadShRh3xsw61D8jvOh0VB46hFqukXWHd56+NwzD+t6xyAaLkKhsjVWL5b4+Rx6EHcxqoS7p1aBAuijM6z/N9qvN1lewM9t2f5XQVV4cu+60V2bNZKrFgSjhjPvFXljPX6qRyJrdlzP81yPdZCzwoWwpVDQoV7276Eo8CE/e+KDxHqfSjm8ycIzvf2zNzZUIgdoFi8aW140UT2ASQupWec2EJMW2QN5Ch7ClDF4kmiXU5DRbiLXEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f45266d-2aba-48e8-c045-08df027fc6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 08:06:32.8041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHWUFe+5KOK5HIxAd0H2u9R2H/t6dwC77fafV40nhDqsqw7Er1NP3akJ0xieTTIx5x5/Z8NuOo76m5HEnx7OQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB9887
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

SGksIFNlYW46DQoNCk9uIEZyaSwgMjAyNi0wOC0xNCBhdCAwMTo1NSArMDgwMCwgU2VhbiBDaGFu
ZyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gDQo+IA0KPiBUaGUgZHJtX3NpbXBsZV9lbmNvZGVyX2luaXQoKSBoZWxw
ZXIgaXMgZGVwcmVjYXRlZCBiZWNhdXNlIGl0IGFkZHMgYW4NCj4gaW50ZXJtZWRpYXRlIGFic3Ry
YWN0aW9uIGxheWVyIHRoYXQgb25seSB3cmFwcyBkcm1fZW5jb2Rlcl9pbml0KCkgd2l0aA0KPiBh
biBlbXB0eSBvciBtaW5pbWFsIGRybV9lbmNvZGVyX2Z1bmNzIHN0cnVjdC4NCj4gDQo+IFJlcGxh
Y2UgZHJtX3NpbXBsZV9lbmNvZGVyX2luaXQoKSB3aXRoIGV4cGxpY2l0IGNhbGxzIHRvIGRybV9l
bmNvZGVyX2luaXQoKQ0KPiBhbmQgZGVmaW5lIGRyaXZlci1zcGVjaWZpYyBkcm1fZW5jb2Rlcl9m
dW5jcyBjYXJyeWluZyB0aGUgY2xlYW51cCBjYWxsYmFjay4NCg0KQmVjYXVzZSBEaW9nbyBTaWx2
YSBoYXMgc2VuZCBzaW1pbGFyIHBhdGNoIGJlZm9yZSB5b3UgYW5kIGl0IGxvb2tzIGdvb2QsDQpz
byBJIHdvdWxkIGxpa2UgdG8gYXBwbHkgaGlzIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaGFuZyA8c2Vhbndhc2NvZGluZ0BnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDkgKysrKysrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGluZGV4IDQ5ZGZjMGY4MjVjYi4uMjc2
ZDU3Zjg0MDdiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rz
aS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTIy
Niw2ICsyMjYsMTAgQEAgc3RydWN0IG10a19kc2kgew0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBt
dGtfZHNpX2RyaXZlcl9kYXRhICpkcml2ZXJfZGF0YTsNCj4gIH07DQo+IA0KPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBkcm1fZW5jb2Rlcl9mdW5jcyBtdGtfZHNpX2VuY29kZXJfZnVuY3MgPSB7DQo+
ICsgICAgICAgLmRlc3Ryb3kgPSBkcm1fZW5jb2Rlcl9jbGVhbnVwLA0KPiArfTsNCj4gKw0KPiAg
c3RhdGljIGlubGluZSBzdHJ1Y3QgbXRrX2RzaSAqYnJpZGdlX3RvX2RzaShzdHJ1Y3QgZHJtX2Jy
aWRnZSAqYikNCj4gIHsNCj4gICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKGIsIHN0cnVjdCBt
dGtfZHNpLCBicmlkZ2UpOw0KPiBAQCAtOTE4LDggKzkyMiw5IEBAIHN0YXRpYyBpbnQgbXRrX2Rz
aV9lbmNvZGVyX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRybSwgc3RydWN0IG10a19kc2kgKmRz
aSkNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gLSAgICAgICByZXQgPSBkcm1fc2lt
cGxlX2VuY29kZXJfaW5pdChkcm0sICZkc2ktPmVuY29kZXIsDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRFJNX01PREVfRU5DT0RFUl9EU0kpOw0KPiArICAgICAgIHJl
dCA9IGRybV9lbmNvZGVyX2luaXQoZHJtLCAmZHNpLT5lbmNvZGVyLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJm10a19kc2lfZW5jb2Rlcl9mdW5jcywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERSTV9NT0RFX0VOQ09ERVJfRFNJLCBOVUxMKTsNCj4gICAgICAg
ICBpZiAocmV0KSB7DQo+ICAgICAgICAgICAgICAgICBkcm1fZXJyKGRybSwgIkZhaWxlZCB0byBl
bmNvZGVyIGluaXQgdG8gZHJtXG4iKTsNCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
IC0tDQo+IDIuNDMuMA0KPiANCj4gDQoNCg==
