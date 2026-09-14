Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEEEC88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34910ED01;
	Mon, 14 Sep 2026 14:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="y3HUJ0ab";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="qACjyWPC";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9626F10ED01;
 Mon, 14 Sep 2026 14:18:24 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED1C2p121687; Mon, 14 Sep 2026 15:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=Pg46o5vNem+AGZoWwbyaHrYpgOPX2uYAW0CF64jlPws=; b=y3H
 UJ0ab5KW1MFN6U6JVir/pHfucrQMs5YFGv8wu+tQMpeqYFQZd15tJm/vCjr+Cznj
 VofKPd4ApaK3KummUH0fFNI7A03A25YvA2eouNsmxhQ4EKHaRB7OOL0B0R1OJC4G
 aRJS+kOFqnGp1kZMd/pBZ1U3yRK2DsDfbLB1sQCdWNzHwzyi55NMs58c1fHru7cl
 aCqJISLVYwTpq8g2pt0hjSecFfc5Ke5pZ9WSuqxII0ErU1ZUqiOqGxnXF7KXykzV
 vlNOeQycO4460edfla+1Q4OuynrenDUwXOntdrNgs29A9LUkY3dQ6zS8Nzu6Y4Wo
 dxLbh+y+R5D1QkO8lPQ==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022116.outbound.protection.outlook.com [52.101.101.116])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtuhpxk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 15:18:15 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXk6JkS+on0TB3KwcscLruW7mlhkDUFv7LnojY96pWAZewUnGvjfUnUau/jc2By/a3hqruOk2wu+bnIhpnp1VeI5weG5g7Bbm+/OciqLtPy4az57bMi//AuqS0MGj2znfqe7qg96aGCL2jkqIOFahyAHyhyYgIgH0LOurhRlZKPuUUu6o9CczYRkIA6wPsv4KbuLXLlX8qrxN1NaBzuN3kNhI/gK67t36MA702UZEAzVX8ksyG45tTQefmjrxq1InoXgxq16Afd7J7yvrCEAbdr2L+gfTg44vTJ6bvJmGAN8d3FBN/rWCbKYp60tOTwyrXND3UI+a0YdbXh07uEBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg46o5vNem+AGZoWwbyaHrYpgOPX2uYAW0CF64jlPws=;
 b=TBTLKTdTNBu+K5/cZb0jtcrf3Rg6VAM8QT/Fh0M9qXAnRgA5FBRHKO/vzsc7FpbbTJgysF6T+oyGFpAHKfo1QlbRL93HW/dtOJtuggbrW1Ladjg9Ylao/bgLO+HdA7ywVURMs4ga1eCivhwZ2tyZDqZvv+XnEk6V2cpFInKgi/80+uce+Qxpc22zk71Wv6q1z2VAVgbNE+OcBeghDrDZuQeHT33BZ8v+kBwTsfp2scr6b8D+vk95u7KdzKSoLK1XsSB+WpBQAS7jBVvR4WfclbX+O/BLnmd7A3FtqNL19CSFilgWLXH4m2CaL1W6JKLEqJUE/hNoTm9LfmY1zl+BQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg46o5vNem+AGZoWwbyaHrYpgOPX2uYAW0CF64jlPws=;
 b=qACjyWPCBhK++FahARNWNUXenlKugD6cbAKmnnCsMJp/xG7DuL/4kLpNlHiTbFjkUwuMbwji4yXJ/cZXprRx0L/c0iVAiAyV+Aw4QeSqM1WHIH+L5odqNjUV9XZrGSNLYe0tpLj9T7mlXofnMXLHi2aldk8cr5ZjElrJuighsek=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOYP265MB2288.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:18:13 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:18:13 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 1/2] drm/imagination: Collect KCCB initialisation
Thread-Topic: [PATCH 1/2] drm/imagination: Collect KCCB initialisation
Thread-Index: AQHdQPn8eKQArUUoEEmsXs5/Ju/78bbOJcsA
Date: Mon, 14 Sep 2026 14:18:13 +0000
Message-ID: <58805f3a663af5efaf2f16ccb6dc8673c749a92b.camel@imgtec.com>
References: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-0-7e10274384c2@imgtec.com>
 <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-1-7e10274384c2@imgtec.com>
In-Reply-To: <20260910-b4-avoid-init-of-unused-fw-trace-buffer-pointer-v1-1-7e10274384c2@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOYP265MB2288:EE_
x-ms-office365-filtering-correlation-id: e666f01d-f4d1-48b6-7366-08df126b033e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: BBjCJX5hNRoBC5FEg587MOYE5NRR4Szlx4Bgq7pjNrV+cIT+IZEfJBNPF5K3IMeT3okcywR90wLsgUYEpl8Khrj9Js3OK+pZ9GVa0DVxhAWJ2Txsn3Y/EbL8AVQAocGXJqf5tQvSZfd/H9YNj1/H3d8TghJG1Ef/giuquDBB89zBuYfwsdEz21i03F4BqaSjP5UIMPQ2AsixgJl8EFUKkaXMsuNXJBuEe3l0DKOZVPysmE0SkbLx4b6u1w2b3Yjx63lt5MoyuZcCanXMOA2oY3aAmLhq+KEH4UV+3iP+xiAGkYY1O7Gf/7Wj+zWrBhcH4hOb7L/AszDtOQ0PD2VBrwEUtj/9s+6iGl9nQkw9ZHY54Fyi+xhDV2mW2W6wp2TkURxWBQNauzwaorTemsMWZ15bFW88M1lbiAWkqQ7NW1JYTG81+cgtEaXOO6sK4xm0PXygKAOe28Edq4MC/yrXRWVlfKMTgn1bu8sdyiPMk6dQ90BWMzslRJEuvSN4k5EZE4pair92rLjdgLY5EajOme1J3BP6JOqbdaGjAkvRsqXMiHol7QwSVK9MqBS6/DJgpdZqXT420HCJ62BtgPgCk521app6n4b3T/tGw7F9IIhbUM6gWjnFsKyvru3Uxu7JmSu8ITTMCkrRj7BNaciLfajZmHB06OGc9q5lIgX8B9hFh8rgH4LZ4xyXf0+bVKQ+m+EOa/xIWOiF9YgQIu3odhEGAoag0KA8+OxQx2LsEtw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG95UytSVEs1SVZSZFhhMEN6ZGgxOFkvKzBOeFVvMEovdzQ0VmNTeUpvSGJU?=
 =?utf-8?B?cloxSGU0RmwyTmI3ZkVrSHhZNnAwbm1paEVvYnlSZ3JnZXFOTW50N1JqS21F?=
 =?utf-8?B?cUtXSHRJU3lMa1dwUS8vQmlRemlYdjBLVFE0V1UxNUxyU1MxMTAvSDc4UThw?=
 =?utf-8?B?TkxJbTNBQjlkWmJOdXZOYytYbGljMUFKakFPdzJKZVVxdWRqQnZvS0ZzZVpt?=
 =?utf-8?B?NHoxNlNtVmFzUEYwNElJeU9nckJESFpGcnVMQThSMHFCRDEyK3REeExseW5j?=
 =?utf-8?B?ajg5WlpXbCtOU1hJc3loMERIVk8vQjEvazArYnlhOUlteldNSVRHdHNJN3pn?=
 =?utf-8?B?cjlzdGlPN2dEbWgwWERybVdQb2NyNjkzL3ZXdDVJK0tUZGNCQ2JHMlNVck5a?=
 =?utf-8?B?eWwvSkhBNWt6NFBXcUFKTUgzckxla1BVaWhkcFZLNUhtdk9XdlZRd3BHL0lP?=
 =?utf-8?B?c05tYzlkYkpJcjdoTWtTd1AwRS91d0tGa3ZXa29hRm5zNU9hNHZhNmVmOHZC?=
 =?utf-8?B?SE5yM3FVdStiZDFrQkh5dk4xdThHNHh3ZzVZcTNzNURzN1lOazRGVFMzRTM2?=
 =?utf-8?B?b0FnU0NSdVkwOU9MN21VVGFaMXZaMXZaUkFzOG44RFRuUjQyazNiMDdKZ3cz?=
 =?utf-8?B?S0J0bzZueEplNkNEZk1EWjBHOERaNkp3L1RObkU3K21lWG15S2VsdlhmVU9F?=
 =?utf-8?B?bUg0MkhGVXhGcU92Rjd4aWlaWGMrK2gyOGo3OXVTVHAxV0x0U2h6bjRjZW9v?=
 =?utf-8?B?eldkRjV5UE03Zi9ISnZkL3JHOEtDSG1FV1FlSFJ0SGJtYjFpY0ZNMWR5aVVM?=
 =?utf-8?B?MVR4dEdxdVUrbkJIRS9PVmNhWHkrd3Y1UjFEU0FiSTBQWHNFVktJRWtFTkht?=
 =?utf-8?B?MjRPRUFiTXRDUkRIQXV4NjJYYThFN2t3RlBVUGZzcWl6UFprNzFKc3ZyZWJl?=
 =?utf-8?B?Y21abmdKNjFkRFFpK1VGR09FNXpGMVgweXdGSy9QdGZZbGJIcTlLVHhFLzVk?=
 =?utf-8?B?Q2VUT1k4VzZUbGw1RzhLcW11b0gwZExWdlp1bWdvMTdtdkVtSzBSUTJqeU9C?=
 =?utf-8?B?MWNHb3NKRmNkclRvREY2WHlBeVd5dXd5L3c1SjI2WDl6ZC9yWEJONnJDelg0?=
 =?utf-8?B?K2lGeTQydHIvak4zaldIWnVTMUk4YzhHcThFb3NVKzIwSUdtWFFtY3ZkalMz?=
 =?utf-8?B?VmU3eXFNZmpBWlFKWmNtYlZLb1VxeU1nbm12M3lpd1pLU0JqMWhkUTJVVnRq?=
 =?utf-8?B?MnpvdVE2SVRVQ0ZrbEF3THk0cWxudmVUekZacnByK3ZENFc2ek5aZDk4RHlJ?=
 =?utf-8?B?ZlE4dWxvaWhrd3J1T0xEY09JNk8rL2V6SXlsdHQvQ2ZWN0I2UFpzcWxkSVZT?=
 =?utf-8?B?TVdCb05Oc2tEby9RZmpPMG1xd0w3U0h2SGFHRU5SVmpYZGFZb2d5WlllS2pR?=
 =?utf-8?B?V1NnMnVJQ2d6ZnJ0cEs5eU4zcFAwYmRlUXBrQ3lxdFJpV3JHbndWeUVMOS8z?=
 =?utf-8?B?bmQvWUdHK1pQNzRPdG9TenBOc0tTS0Rmb0Rxblo1Rkt2dFYwVmxYeXNmUE80?=
 =?utf-8?B?ZklManNRTVJJVnM1ZTM1VVlOeXJmb1FVL2haWVlVejhReFMyM3ZRSXJrN1R0?=
 =?utf-8?B?VXNsY0lqR0FoNERXeFphMVZHbU1iOFVob2UwUUM3K1I5Q0FhWHZtYnRiNmgr?=
 =?utf-8?B?S2ZINWJZVHFxSmlvb0JvZzdkZngyVzVUcXJBM244czZycjB5anNKL3NudlV4?=
 =?utf-8?B?MktwYnlMaEZ0UThrd1I3eVN1ZjBsUWlmNUhaYUdmaDJLRGw4djYrYkJYbktT?=
 =?utf-8?B?TTUvOUhYUms1d2RGdk5wQnMyeThQRzI3N1Zsbll6SHNmYzdJb0wwdzVoNnFR?=
 =?utf-8?B?WG1PTndWNW5MeTBTOXhpUFZmWHRlU2FlVHk2YUp3NEN3SE9La2RxUXhmcEsx?=
 =?utf-8?B?aWxheUE1cWZCL240a1AyVk44NzcvbjRGNVRvR1NJREV5Mk9FZVdMdDRRQy83?=
 =?utf-8?B?R3FaTVlqbUY2dzNYbDZwQWtsWFlXVHIyVjVaR2NEckZXTUU2K2lYS0VxeUJK?=
 =?utf-8?B?K0lnc2hvQWF5Y0JrV3hwY29RQzhvN0RCaFlwVVRraGhRanJ4SGVzaWNzSGky?=
 =?utf-8?B?Zmp5RTZXdWdsdnVyMlI3dWJSQ3VnZmFqYXdiRVFJR0JReXUyNnVtc282ZzZY?=
 =?utf-8?B?Y2NnQUdpMkFwZW9jTHFKYmxKVi9nYzdRSjlhdUROaThJQ2Z6SVg5TFNTQkc5?=
 =?utf-8?B?YWlIZFJhZ3VLS2xVeW1vNy9kNkt5ODY0WmJ6dGVudHU5VzhhWVNCeHllT0NP?=
 =?utf-8?B?cHMxUkJJRWIvOHJIZjJNekZ4dFdWam9kdFhBUnNkNWNlZGhGQ0paN3huRktU?=
 =?utf-8?Q?LI/igHzPTV6a92Pg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD7B68077481854EBA1AB57128BF1DC6@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i31sqk17slwBv5l/2UHNZihL3Pd/37KKkdRY9tZhEi+d6VJUYmGol3CVEPx8tSMD4RVAzIXQTvPcn+YjQxLMpFaeGvGh4Br0SJm4jmsEQYIjGQy676HNvQ07wza9ljWOItpiPPTxQOsIpJ1q92INlMGNZKp1DbVHCm6TnOapb4Cai23adWt3WN4qo2MOti+4IBWAmu3/fHqmYIHBOtpQZ6BUg3d63mg6/eZZo37p5FllN8CkRuUFoIBReqSh6uJhcUheR7HXcTn+TRFqjan1K1vaY8DpbVHMDS8+eCwzBen3Q9A3zYLZROjQAs4nymOD4creoLmPP0ShuUu/jYUorw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e666f01d-f4d1-48b6-7366-08df126b033e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:18:13.5021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3f6Jyg7pYm+zUfOK3yFjXkZQ0B6HME5LEeDtMyHnFMF22VUtoTdCXWttuZo7XGud3ccTU3NdDajp/JwUw8DN5bFbP3sIx6NDIXn+pqNuem4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2288
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa80228 cx=c_pps
 a=81Yf6olBxobXKiR6zWkFJA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=MflLQ4FaAsIQE3WtW4cA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: d25d2pTKV18nT_SY08m74pdemxy-g-o7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNCBTYWx0ZWRfXxpMy5+eepwIH
 jWPMTn/3x7CATnLJ0CTZJ8AUz5beNXmZ2YBFue+lDAAwIdXTTqrTGAisJ+v9yh628WvUVjyB4Fw
 9Il9Uw5f3q4hgccMqJltvztVXFXrkWR/wMt6HFqe9ITeQP8aUV/3680arE/3TY//t5Uwk5NcQXW
 sH0mA6YzCQh2WShyIuYuIGwdQQbAF6EXRZvIoZJVBm7JdLVS2O2i+lzK3R1QQXATa87PybVLATo
 TSl/zXKf7N5xQ5hDT1ANniQSrwcKOFnnX2eGHaOOIIpCmSOrpoZP333gDK4hE/4ozfXIJ0cg3Vo
 lofQ+CR7XDSOeOZT+C/N3WBt1CnR2YSY1vWNmaoS+dNHAuxgZX/qV0z4Oo1GQnqO9W4ZLkWDysG
 u0FJFFvX8VBUSl++dwSfRQQRZxm3rrsIODBUP4ZLl+93GyCKY8ycCy9FmZ/qPW1bzoiqBdtqq5Y
 ewYsIJ9XQ9VMF9ySLjA==
X-Proofpoint-GUID: d25d2pTKV18nT_SY08m74pdemxy-g-o7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNCBTYWx0ZWRfX497xqqxZ26Ne
 +wtPsNQJwGSPpckYC4lSZmueIOxocQx+L/4gwEcfRa+zRuVKQINWW4qEkNpq/dZ5zq+uZgHrbr2
 +ahldlrMLWfduHPJdyv06xoKF0/G3N0=
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

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDEwOjU2ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gRnJvbTogTWF0dCBDb3N0ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQo+IA0KPiBUaGVy
ZSdzIG9uZSBGVyBvYmplY3QgYXR0YWNoZWQgdG8gS0NDQiB1c2FnZSAodGhlIHJldHVybiBidWZm
ZXIpIHRoYXQgaXMNCj4gc2VwYXJhdGVseSBpbml0aWFsaXNlZCBpbiBwdnJfZndfaW5pdCgpLiBN
b3ZlIHRoaXMgaW5pdGlhbGlzYXRpb24gdG8NCj4gcHZyX2tjY2JfaW5pdCgpIGFsb25nc2lkZSB0
aGUgaW5pdGlhbGlzYXRpb24gb2YgcmVzdCBvZiB0aGUgbWVtYmVycyBvZg0KPiBzdHJ1Y3QgcHZy
X2RldmljZS0+a2NjYi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNv
c3RlckBpbWd0ZWMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFu
ZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNz
aW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jY2IuYyB8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3
LmMgIHwgMTcgKy0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRp
b25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX2NjYi5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9jY2IuYw0KPiBpbmRleCBiNzAyZDEyMmQ3OTEuLjNiNTk0MmI2NzRiZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9jY2IuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2NjYi5jDQo+IEBAIC0xNyw2ICsxNyw3IEBADQo+ICAj
aW5jbHVkZSA8bGludXgvamlmZmllcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb3ZlcmZsb3cu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3dvcmtx
dWV1ZS5oPg0KPiAgDQo+IEBAIC01MjcsNiArNTI4LDcgQEAgdm9pZCBwdnJfa2NjYl93YWtlX3Vw
X3dhaXRlcnMoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ICAgKi8NCj4gIHZvaWQgcHZy
X2tjY2JfZmluaShzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIHsNCj4gKwlwdnJfZndf
b2JqZWN0X3VubWFwX2FuZF9kZXN0cm95KHB2cl9kZXYtPmtjY2IucnRuX29iaik7DQo+ICAJcHZy
X2NjYl9maW5pKCZwdnJfZGV2LT5rY2NiLmNjYik7DQo+ICAJV0FSTl9PTighbGlzdF9lbXB0eSgm
cHZyX2Rldi0+a2NjYi53YWl0ZXJzKSk7DQo+ICAJV0FSTl9PTihwdnJfZGV2LT5rY2NiLnJlc2Vy
dmVkX2NvdW50KTsNCj4gQEAgLTU0MywxNCArNTQ1LDQyIEBAIHZvaWQgcHZyX2tjY2JfZmluaShz
dHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIGludA0KPiAgcHZyX2tjY2JfaW5pdChzdHJ1
Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIHsNCj4gLQlwdnJfZGV2LT5rY2NiLnNsb3RfY291
bnQgPSAxIDw8IFJPR1VFX0ZXSUZfS0NDQl9OVU1DTURTX0xPRzJfREVGQVVMVDsNCj4gKwljb25z
dCB1MzIgbnVtX3Nsb3RzX2xvZzIgPSBST0dVRV9GV0lGX0tDQ0JfTlVNQ01EU19MT0cyX0RFRkFV
TFQ7DQo+ICsJY29uc3QgdTMyIG51bV9zbG90cyA9IDEgPDwgbnVtX3Nsb3RzX2xvZzI7DQo+ICsJ
dTMyIHJ0bl9zaXplOw0KPiArCWludCBlcnI7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBpbnB1
dHMgaGVyZSBhcmUgY29tcGlsZS10aW1lIGNvbnN0YW50czsgdGhlcmUncyBubyByZWFzb24gdG8g
dHJ5DQo+ICsJICogdG8gZ3JhY2VmdWxseSBoYW5kbGUgb3ZlcmZsb3cgYXQgcnVudGltZS4NCj4g
KwkgKi8NCj4gKwlCVUlMRF9CVUdfT04oY2hlY2tfbXVsX292ZXJmbG93KG51bV9zbG90cywgc2l6
ZW9mKCpwdnJfZGV2LT5rY2NiLnJ0biksICZydG5fc2l6ZSkpOw0KPiArDQo+ICsJcHZyX2Rldi0+
a2NjYi5zbG90X2NvdW50ID0gbnVtX3Nsb3RzOw0KPiAgCUlOSVRfTElTVF9IRUFEKCZwdnJfZGV2
LT5rY2NiLndhaXRlcnMpOw0KPiAgCXB2cl9kZXYtPmtjY2IuZmVuY2VfY3R4LmlkID0gZG1hX2Zl
bmNlX2NvbnRleHRfYWxsb2MoMSk7DQo+ICAJc3Bpbl9sb2NrX2luaXQoJnB2cl9kZXYtPmtjY2Iu
ZmVuY2VfY3R4LmxvY2spOw0KPiAgDQo+IC0JcmV0dXJuIHB2cl9jY2JfaW5pdChwdnJfZGV2LCAm
cHZyX2Rldi0+a2NjYi5jY2IsDQo+IC0JCQkgICAgUk9HVUVfRldJRl9LQ0NCX05VTUNNRFNfTE9H
Ml9ERUZBVUxULA0KPiAtCQkJICAgIHNpemVvZihzdHJ1Y3Qgcm9ndWVfZndpZl9rY2NiX2NtZCkp
Ow0KPiArCWVyciA9IHB2cl9jY2JfaW5pdChwdnJfZGV2LCAmcHZyX2Rldi0+a2NjYi5jY2IsIG51
bV9zbG90c19sb2cyLA0KPiArCQkJICAgc2l6ZW9mKHN0cnVjdCByb2d1ZV9md2lmX2tjY2JfY21k
KSk7DQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCS8qIEFsbG9jYXRl
IG1lbW9yeSBmb3IgS0NDQiByZXR1cm4gc2xvdHMuICovDQo+ICsJcHZyX2Rldi0+a2NjYi5ydG4g
PSBwdnJfZndfb2JqZWN0X2NyZWF0ZV9hbmRfbWFwKHB2cl9kZXYsIHJ0bl9zaXplLA0KPiArCQkJ
CQkJCSBQVlJfQk9fRldfRkxBR1NfREVWSUNFX1VOQ0FDSEVELA0KPiArCQkJCQkJCSBOVUxMLCBO
VUxMLCAmcHZyX2Rldi0+a2NjYi5ydG5fb2JqKTsNCj4gKwlpZiAoSVNfRVJSKHB2cl9kZXYtPmtj
Y2IucnRuKSkgew0KPiArCQllcnIgPSBQVFJfRVJSKHB2cl9kZXYtPmtjY2IucnRuKTsNCj4gKwkJ
Z290byBlcnJfY2NiX2Zpbmk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK2Vy
cl9jY2JfZmluaToNCj4gKwlwdnJfY2NiX2ZpbmkoJnB2cl9kZXYtPmtjY2IuY2NiKTsNCj4gKw0K
PiArCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9mdy5jDQo+IGluZGV4IDg1MGEzZWM4ZTc3NS4uY2VjMTczNTJjZjkwIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+IEBAIC05NDUsOCArOTQ1LDYgQEAg
cHZyX2Z3X2luaXQoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ICAJCVtQVlJfRldfUFJP
Q0VTU09SX1RZUEVfUklTQ1ZdID0gJnB2cl9md19kZWZzX3Jpc2N2LA0KPiAgCX07DQo+ICANCj4g
LQl1MzIga2NjYl9zaXplX2xvZzIgPSBST0dVRV9GV0lGX0tDQ0JfTlVNQ01EU19MT0cyX0RFRkFV
TFQ7DQo+IC0JdTMyIGtjY2JfcnRuX3NpemUgPSAoMSA8PCBrY2NiX3NpemVfbG9nMikgKiBzaXpl
b2YoKnB2cl9kZXYtPmtjY2IucnRuKTsNCj4gIAlzdHJ1Y3QgcHZyX2Z3X2RldmljZSAqZndfZGV2
ID0gJnB2cl9kZXYtPmZ3X2RldjsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IEBAIC05ODEsMTggKzk3
OSw5IEBAIHB2cl9md19pbml0KHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2KQ0KPiAgCWlmIChl
cnIpDQo+ICAJCWdvdG8gZXJyX2tjY2JfZmluaTsNCj4gIA0KPiAtCS8qIEFsbG9jYXRlIG1lbW9y
eSBmb3IgS0NDQiByZXR1cm4gc2xvdHMuICovDQo+IC0JcHZyX2Rldi0+a2NjYi5ydG4gPSBwdnJf
Zndfb2JqZWN0X2NyZWF0ZV9hbmRfbWFwKHB2cl9kZXYsIGtjY2JfcnRuX3NpemUsDQo+IC0JCQkJ
CQkJIFBWUl9CT19GV19GTEFHU19ERVZJQ0VfVU5DQUNIRUQsDQo+IC0JCQkJCQkJIE5VTEwsIE5V
TEwsICZwdnJfZGV2LT5rY2NiLnJ0bl9vYmopOw0KPiAtCWlmIChJU19FUlIocHZyX2Rldi0+a2Nj
Yi5ydG4pKSB7DQo+IC0JCWVyciA9IFBUUl9FUlIocHZyX2Rldi0+a2NjYi5ydG4pOw0KPiAtCQln
b3RvIGVycl9md2NjYl9maW5pOw0KPiAtCX0NCj4gLQ0KPiAgCWVyciA9IHB2cl9md19jcmVhdGVf
c3RydWN0dXJlcyhwdnJfZGV2KTsNCj4gIAlpZiAoZXJyKQ0KPiAtCQlnb3RvIGVycl9rY2NiX3J0
bl9yZWxlYXNlOw0KPiArCQlnb3RvIGVycl9md2NjYl9maW5pOw0KPiAgDQo+ICAJZXJyID0gcHZy
X2Z3X3N0YXJ0KHB2cl9kZXYpOw0KPiAgCWlmIChlcnIpDQo+IEBAIC0xMDE0LDkgKzEwMDMsNiBA
QCBwdnJfZndfaW5pdChzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldikNCj4gIGVycl9kZXN0cm95
X3N0cnVjdHVyZXM6DQo+ICAJcHZyX2Z3X2Rlc3Ryb3lfc3RydWN0dXJlcyhwdnJfZGV2KTsNCj4g
IA0KPiAtZXJyX2tjY2JfcnRuX3JlbGVhc2U6DQo+IC0JcHZyX2Z3X29iamVjdF91bm1hcF9hbmRf
ZGVzdHJveShwdnJfZGV2LT5rY2NiLnJ0bl9vYmopOw0KPiAtDQo+ICBlcnJfZndjY2JfZmluaToN
Cj4gIAlwdnJfY2NiX2ZpbmkoJnB2cl9kZXYtPmZ3Y2NiKTsNCj4gIA0KPiBAQCAtMTA0Nyw3ICsx
MDMzLDYgQEAgcHZyX2Z3X2Zpbmkoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYpDQo+ICAJV1JJ
VEVfT05DRShmd19kZXYtPmluaXRpYWxpc2VkLCBmYWxzZSk7DQo+ICANCj4gIAlwdnJfZndfZGVz
dHJveV9zdHJ1Y3R1cmVzKHB2cl9kZXYpOw0KPiAtCXB2cl9md19vYmplY3RfdW5tYXBfYW5kX2Rl
c3Ryb3kocHZyX2Rldi0+a2NjYi5ydG5fb2JqKTsNCj4gIA0KPiAgCS8qDQo+ICAJICogRW5zdXJl
IEZXQ0NCIHdvcmtlciBoYXMgZmluaXNoZWQgZXhlY3V0aW5nIGJlZm9yZSBkZXN0cm95aW5nIEZX
Q0NCLiBUaGUgSVJRIGhhbmRsZXIgaGFzDQo+IA0KDQo=
