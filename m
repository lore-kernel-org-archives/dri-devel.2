Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B2EC88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C0F10E330;
	Fri, 11 Sep 2026 10:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="fH64B8XO";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="ArjkxMnL";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1FE10E330;
 Fri, 11 Sep 2026 10:21:09 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7nJb2278362; Fri, 11 Sep 2026 11:20:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=qGqOzBXEbCxP1di7g0QSQJa3fHCpD4YKFubpTq0ZvqA=; b=fH6
 4B8XOXUhnaTz3hi7i4VfozaTtYLeX/7zrgvAD5Zu8yCzVPge0HrdTUHCvWoQITo8
 ZAAnsfAzmlLwxzUec1+g8bwKBq653ZlsCOxl/xIZqVnXznSELzutk+CyEL8bEOIb
 BnSOwBNQdlJW0ikBuKX5JvRuRMwWBfkpWbMASMY/401yefrNlcKXbiIqqyneyhNB
 xS7eXcahR4ho9KLJelevRaJL+xQvUSw6P7C1n614gxxQdmnNS0lJUppy1NRV5CnD
 Knd6cUPujgyds0WMeM/RIJCBA+2H8p3PAXp2oW/jeQoK+6KUQonUHkAm/ofuvKvh
 JKkuzVzGxtu4PP4PJpQ==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gkk71s7n8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 11:20:53 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU4zNz/tCtOwhwqFaIoa+NVTY8HPIPnxx9Q4n5t/f798WhjvZvip5hSQC1nFjXF6Pl0yuhdGGHxuJEWodiEKyyO0pvSt0nDPAaOwDyQtlSwm6+XW6N8vbTdhcUbzh4XPokPrFR4x/esF0jsb00WjJH1dBNjDnOp2JLvJjMivyHKBbQrWcnGq62i0hNzIXgdVYLjJOC2+j1Q1x+YCNpG2a6U5odfnClUsYy2BVkME1FE0kLNQZoza5LVaEfAXYZoQM8h+WI4VMiBYHSq/qjkiDVVSXiEQm19NKMGzKLxSbAS1VnSL74KJnf0e+k4Y8mTFotXRRA2ArOamEfAvl+TQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGqOzBXEbCxP1di7g0QSQJa3fHCpD4YKFubpTq0ZvqA=;
 b=Dv/tlqZKxMrLVGwHqzjDUHo06RguD5tgFZsb0E/XbOUVgbDa8LIzVHWcuG6Yd9Os7NLC3gZyAdm8UiBWOHWqWINKnRm0dYgJWln9whk2NE7QFVATcg2ZD3Nxpg/EdOXepjorDImE/yC9LvJEmtG08Cw+3lhICTG6ZRBi+o/ALHtap8dBR6UQrJM2rfP4dcY58fa+8+5mRkwyAFxC6ygo1Jn2FfEXPVvpiM7/8S5GpLrAD0W/qEWuP94LdUnt/roRsjZvzB78cirplOkYa7qPsHN8j1pSaWvru7ARpEJ2ZvT0jSmWQAtt/1Nee4p7aSi5/i5mJQP90Psvn+Ici8qrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGqOzBXEbCxP1di7g0QSQJa3fHCpD4YKFubpTq0ZvqA=;
 b=ArjkxMnLJpNy1EdZUdeFstYFmEzdQKoz6/uCCuwk6tS3JKRtwApEPmxGspUHfskMv+CqB58fiSpsvxuNhnzkl4nUx7G+eZGRu2wATuEswi1/Qd0DpZVu9kRJdeS3pzqYmyXMjabsJNlnmkaFoljHjm0ATxQmLTTYmibou7yKNFo=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWLP265MB7195.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 10:20:49 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:20:47 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "geert+renesas@glider.be" <geert+renesas@glider.be>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "anh.nguyen.pv@renesas.com" <anh.nguyen.pv@renesas.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "mripard@kernel.org" <mripard@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: gpu: img, powervr-rogue: Document
 R-Car V4H and V4M support
Thread-Topic: [PATCH/RFC 1/3] dt-bindings: gpu: img, powervr-rogue: Document
 R-Car V4H and V4M support
Thread-Index: AQHdQdc2QMY/kw3LqEOsyFTlDYAx+w==
Date: Fri, 11 Sep 2026 10:20:47 +0000
Message-ID: <497bc6a40d67f01decfcc2f52e9b8d57754f21f6.camel@imgtec.com>
References: <cover.1789028076.git.geert+renesas@glider.be>
 <1c2771f8882cde0fde694b9f5aae50c02a2ae4cb.1789028076.git.geert+renesas@glider.be>
In-Reply-To: <1c2771f8882cde0fde694b9f5aae50c02a2ae4cb.1789028076.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWLP265MB7195:EE_
x-ms-office365-filtering-correlation-id: 44df9d6b-90bc-4302-d861-08df0fee58cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|56012099006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: opxsAsp7sE5dWYaEmGi5Pzm7IbE+UfR4qG4kBJ0uq43Wy+sHVHQh5PdazadVbvKl33VfmX1hw/slXCOrqHKES0AK4P4gssyYGz793rV34ISAtl1ia1OU0ODU6u7dK7YP7rHGQ0Z3DZW/wWH5ePpsAmWKobLtv5YdNYDPlfVN+RSFK/hR0WVcKC1uXSmUK9wNLQSEQFgPmZ5Kdv72+YMT169R6zAnV06z/RWK2twswAzf1KygOxdaTwBjlXsGlsL3payPEGnklJQ+Ts2MqcpDGDzAJg5ZPzsuaVIEUmSZkKCaOTzXv/dF4IH54RFrLz2xRq48DxT3+5Fwn9MQ0jnfralqlel/VagQXS2RJiTCYk/IpxV4QGU/zIwNhDZ4Xso7d7qN0TLbADB+jMVrFJLkCA9yrXq+G6io8mWMtEqDVLdKDOVjkitADvUARWjum9ZJiuKlwGUFp6ogzsGvirrji6hUvKD+Uoh/8dIwbTcZyqJTf9F++NyiKS2nBdmEitEjM55yQzZmCywzbi0GhSyfSpjr82PUXGIYiZMDmzDHM0rNO9t9wm2x+p0I3w5KVQlqjECsaUeYdYHeCQulzISr/iyH9aORCzyoC6x6PKc7k0xVpAxAodotfhIFmi753VGn4BHjmDb5RyjFv/lS6omo9Z1Kp4xhP1iUV0Y9zF6Wu2q9mRo1JD5GiDq+HnktZwHQxcM801Vm9kReLn2rRc9g5LXXcpUDBoK4gfHGtjfXxtc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckNNcTR2c1BRZ250RmpvSVhBanVZbkF3ekVTRG5uTFgxSGF0T0xWSFpmbUp3?=
 =?utf-8?B?bmxvR2svaDIyYnBDNmcxTWthN2o2RmNCbzZtdWtVYnZWTUdSZmlMSzhKTnBh?=
 =?utf-8?B?aEJTSlVkZSs0SUs3Uy9iV29pandEV2IwT0EreCszb0t2SHRGZWh2SUZQVmI1?=
 =?utf-8?B?cVVxT1piSnNSSnVGeWpqN0RzMGt1KzRhaTFpblYyUHdMdVliVVNLQWZWdDE5?=
 =?utf-8?B?dTVBZ2p4b1lRU01IaUlGai8yS2tYenpNQ2h6c1liL1VialFnZkdqRjI2ZkxP?=
 =?utf-8?B?QzI1VWlXMFFCMU9RbXc2WXRneWFBKzJoVWRrLzVmd3lsVTFUczhOTER3VGF4?=
 =?utf-8?B?MmRCUFFIZFdWSUtxR2licmdiU1dVZ0tzOWRHM3J5T0U1ZlhCbjdQdkdxUCsz?=
 =?utf-8?B?OUY0Q3JwaDBKRDFYc1hKVDd2S1l3SW53TUIrN2FnaHFJZUgyU1J3a0lQeU1p?=
 =?utf-8?B?MEhzLzRmVTRUSWxDS0ZrL3JiekpwdUpkc2dnYUNtMmsxMDl3MFBaOTFTemFh?=
 =?utf-8?B?RnZiTjZLZ3hVbUhaOWV4M0IyQnY5Ry9xM280dDBhOFBsMWlPaEw2eXp0UGlp?=
 =?utf-8?B?VzFCOHRkaGdKQnRDUmYva0VJQ2c1NFFFVXIweEtiZUtNL2tZRWR1N2lCTTZL?=
 =?utf-8?B?b3RHdTBDejkzZnEzK0VWdEdmc2lFdmpvd0dsU1NLQkI5RkJKOXFmeWd3Y005?=
 =?utf-8?B?bC8xTFU0Qi9ubTJaSkN2SFZmbGZQMXJpUE9reVAzOS95WHk3SDFNdUZhVXV5?=
 =?utf-8?B?TWxLMWlQUWlKMktYazZrb050UTBFYkQ1ZzlzTmYwWHVOejBycnRVL0pjODhL?=
 =?utf-8?B?dzNlbVIyYzFpdUN6bkdZeHFWQUxoTVNIOXlHVkcybnVEVGJ0UFQ2cmRSeEVa?=
 =?utf-8?B?aGpYYkQrVmtrMHRCbS8vUHEyejUzNFVRaXRvU3hmWVNSbzRDUnNWb1RDdm9F?=
 =?utf-8?B?RlZlTzB4c1RXMXdIMS92TFlWd1A1azRneXdGYkt4MHVkUkRTQUxCWUdML0RD?=
 =?utf-8?B?NU9ObUNBYi9Ka1JCVXJRZExNbGlFOW1SdFFmME4rR2p3TktqMVIwUWFBZDNL?=
 =?utf-8?B?NXEwNitCdjVKWEZVRzBmekdvK1psSk40OXRPR2lqNmdlMTEyUlNtbXlZN0xK?=
 =?utf-8?B?ZXo1S3JlTVJOQWZnaWJBTERCL2Z5RzRSbUhvRng2QXB1a1ZpWVEwYkxUNnNG?=
 =?utf-8?B?VUJmRm1hUUdYMmlDSXAxUVo2S0hpcitGNkNGang1QVJWK05sYjhkNEhNdnZl?=
 =?utf-8?B?YkNQWVg2M0IyanJMMTFLSnNOMmdGQ2J4VC9WQWJaNW44RTFJelhra2ZqRjJR?=
 =?utf-8?B?eEgwQ3ZCNzB2NjY4cDhxVXVUbEFEMW96MTVnbE1DMXg1T09nRXZMWmU5K3Nm?=
 =?utf-8?B?ajF4UFR2bTBheFVsdzdoM2xCWXUzZlFqUzRLNm8rdU51QVlBV3JSVnc0L3Q5?=
 =?utf-8?B?dmV0MDEwMmppOTZidjFocEV0QVBkc0hxWXdoYzRxdzRYUGVHWVlqcGRSRXJ5?=
 =?utf-8?B?a1cwb21TSlN5OTlNUzRyK3ErODV6MHVxZGo2RDQyYVhxZXVBVTJRR056OG44?=
 =?utf-8?B?TDNPMlNGb1pBMDBVdUxiYU4vT3pOSzNYM0RKd0dmZXpGYmxDT0VpNzc1SGgv?=
 =?utf-8?B?S1pLTmFuMmZoSlpIQ0M3MXMxVkdJalUyaGQ5LzdjSFdyUVR0UnlvVnJVUExC?=
 =?utf-8?B?NmZvRVluTWUvS1p3OUNNclI2d1lvaityMUx1QnN2QURIakhxblY1ZzJ4TnVl?=
 =?utf-8?B?VEtyVC8waUdsYVUrK3Z6cURJM2xMb203UjNNWG9Cbm5kY2VVRkswcWdodXJV?=
 =?utf-8?B?UzMvdW1lZXpOckR5WEh0VzZRY3pUY09YVEI2ME1vVUxTYW0yLy8yRm42UUkz?=
 =?utf-8?B?OFo0Q0FaaFZvL0hFcWJ4SzVTamc1cFRtVndKYTUrZ29WZmM2SlA2OUM1OXAr?=
 =?utf-8?B?Y3pjVytjdFBtbGU3K3UyUWVkN2lmNnl1Vkt3Rlp4OTBOQ3dwRkQzVG04WWsv?=
 =?utf-8?B?N3BnbEQ1WS9tMkJZWUMvVkNJTmpQalhIMm9BR2J1T0NXaHVncG1uWU5tZlBx?=
 =?utf-8?B?em5EQTVjY2s0aC9xVUNkc0w1c2x4VEw3bklwUGdtdFh3Y1ZIb280MXVRNytF?=
 =?utf-8?B?aWxQOWpDSHljVVZkZkw1bXQ2UW5PcmQvTWQ3RU9mTWtwcGVYZ1hrZm1kY3J4?=
 =?utf-8?B?cmlRcFpQcEU1NDJQQ3RlYkpwMnhSYmpZYVk2UTZjK0FmY3l3Q3EzWEZHMGpI?=
 =?utf-8?B?TFowdm1FLzBySDdGT0ZVN3lnNHgxVlBhckVvVEJXRUtYS2QrRjFVSU0rcGRV?=
 =?utf-8?B?TDdSRFNLUllSMXJUYmRoakZpUEthUmVoa1plOTh1MmkwTERhZHU2ZDBkeWhr?=
 =?utf-8?Q?5+davMcy/6SxnjiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7203373111979C4C975F4E6D3F7503E9@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eGjPBhigfQNcmgEnlQuc1TcarrXAYVG1eBbHTgW8IUbZ6JU3GxY1Rb7CfH3vyDlbwut6i9KB4e2zdUddjyaZDkECaW16lLiZl+ygMvj0RQV1ulKm7rz0ZhlmCbs03+Nof3Q2Qm40wI0zczBj/J2ReROCiS/6JeVUjh4FwfRAz8RRrdgA9D7RWLJ14HWMF+qxtQNChpdxROl+Um16rRsxwRsgpCsj2IuBI+1YWEefSixA/9P4pivq7JXk6Q+niWzkZaDp2z9isvFCpQVMSgPTp4jl3RF+3s8+8f3+sPTPNk8CNo4SauU+OhGyRSKaF3M8GsRfpwg9Vmzp2elNeH2f3w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44df9d6b-90bc-4302-d861-08df0fee58cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 10:20:47.5951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tmtk4tlvlNzMw5WzTStKWs2RcW3dDC7Bf1r15/Anaz3RqHeowzeFp4y9FmVMa7jfRwblFMKJNreNuGJxfzIXaEAlScPUfhz24BDx9PZm774=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7195
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NCBTYWx0ZWRfX2Ey3Ow4UfYQx
 o6AWUhjwVBs6SrjUEeShU6V8TVJ83nEb/SeWRnHqoSKI97yVwUCz3w1xI/0rWJBg+lTAuxWjk0B
 3CtirvwuOUsIts0bnTgI5qRI764VcWI=
X-Proofpoint-ORIG-GUID: FbYmAlgGPxtiSwEgoV_tPhTqStU3gTOu
X-Authority-Analysis: v=2.4 cv=IqGL47/g c=1 sm=1 tr=0 ts=6aa3d605 cx=c_pps
 a=/QCTiE6iyTdx+qHPJesQ+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=DYpTl3Kn79D9cagI2DQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FbYmAlgGPxtiSwEgoV_tPhTqStU3gTOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NCBTYWx0ZWRfX5rDP0mkkdiz+
 8VD+flM6wyU+LTSgHdrqKAeJZHjVI9X1g+4upeloQ2blOkhzXm+/8arS21RmEoRMo5LFRBde67z
 Lb9fqDw33hGVZF6ugr9p91PeM6hdzdKN9qLRiFx7kJ3UzHXsfQtYbga/XwlxKa39Wuzq4B/1dCz
 0v3lbIJ3aUNiLOWZR2RuB15Nl8z2TLosQEpLWGu0KV5i7iQxMlkM58DA5I54UWfrQ2CSKLxgnp2
 QxwCgDSjtKLXyR8K343wtOChB9kCabXdemVW5k/5fI3GfErp+MiF5xnfEQX/tbeSohc7AYXfp8v
 1oSVqjlZ7/3OGfyYl1rDFUkR49cJkCDpdc++qCQSLeayBOINooDgdTbqnnsqWFqfR+YMH+zzmjH
 luP8bBwiXnZGzs21v40q/3ZYrxQZUNmg5W517fvfjbqkcn/5g/yiiNV68vm1+HIZEir+nN2tc3h
 0nW/PgATg+JBN/HcsBg==
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

SGkgR2VlcnQsDQoNCk9uIFRodSwgMjAyNi0wOS0xMCBhdCAxMDoxOSArMDIwMCwgR2VlcnQgVXl0
dGVyaG9ldmVuIHdyb3RlOg0KPiBUaGUgUmVuZXNhcyBSLUNhciBWNEggU29DIGludGVncmF0ZXMg
YW4gSW1hZ2luYXRpb24gVGVjaG5vbG9naWVzIElNRw0KPiBBWE0tOC0yNTYgR1BVLCB3aGlsZSBS
LUNhciBWNE0gaW50ZWdyYXRlcyBhbiBJbWFnaW5hdGlvbiBUZWNobm9sb2dpZXMNCj4gSU1HIEJY
Uy00LTY0IEdQVS4gIEJvdGggdmFyaWFudHMgY2FuIGdlbmVyYXRlIDggaW50ZXJydXB0cy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+DQo+IC0tLQ0KPiAgLi4uL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1yb2d1ZS55YW1s
ICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dlcnZyLXJvZ3VlLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2ltZyxwb3dlcnZyLXJvZ3VlLnlhbWwN
Cj4gaW5kZXggZTkyMThlMGYzNjNkMTg0OC4uOWJlYTAzNzYwMmMxMzdhNyAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1yb2d1
ZS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvaW1n
LHBvd2VydnItcm9ndWUueWFtbA0KPiBAQCAtMzUsNiArMzUsMTEgQEAgcHJvcGVydGllczoNCj4g
ICAgICAgICAgICAjIHdvcmsgd2l0aCBuZXdlciBkdHMuDQo+ICAgICAgICAgICAgLSBjb25zdDog
aW1nLGltZy1heGUNCj4gICAgICAgICAgICAtIGNvbnN0OiBpbWcsaW1nLXJvZ3VlDQo+ICsgICAg
ICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAgICAgLSByZW5l
c2FzLHI4YTc3OWcwLWdwdQ0KPiArICAgICAgICAgIC0gY29uc3Q6IGltZyxpbWctYXhtLTgtMjU2
DQo+ICsgICAgICAgICAgLSBjb25zdDogaW1nLGltZy1yb2d1ZQ0KDQpJdCB3YXMgYWxyZWFkeSBw
b2ludGVkIG91dCBpbiBhbm90aGVyIHJlcGx5LCBidXQgQVhNIGlzIGEgVm9sY2FuaWMgR1BVIHdo
ZXJlDQpWb2xjYW5pYyBpcyB0aGUgYXJjaGl0ZWN0dXJlIGZvbGxvd2luZyBSb2d1ZS4NCg0KV2Ug
d2lsbCBoYXZlIGEgc2VwYXJhdGUgc2V0IG9mIGJpbmRpbmdzIGZvciBWb2xjYW5pYyB3aXRoIGEg
ZmV3IGRpZmZlcmVuY2VzDQppbmNsdWRpbmcgYSBuZXcgYmFzZSBjb21wYXRpYmxlIG5hbWUuIFRo
ZSBkcml2ZXIgaXMgZ29pbmcgdG8gYmUgdGhlIHNhbWUsIGp1c3QNCndpdGggYSB3aG9sZSBsb3Qg
b2YgY2hhbmdlcyB0aGF0IGFyZSBzdGlsbCBiZWluZyB3b3JrZWQgb24uDQoNClRoZSB1cGRhdGVz
IGZvciBBWE0gYW5kIFY0SCBmcm9tIHRoaXMgc2VyaWVzIHdpbGwgbmVlZCB0byB3YWl0IHVudGls
IGF0IGxlYXN0DQp0aGUgbmV3IGJpbmRpbmdzIGhhdmUgYmVlbiB1cHN0cmVhbWVkLg0KDQpUaGFu
a3MsDQpBbGVzc2lvDQoNCj4gICAgICAgIC0gaXRlbXM6DQo+ICAgICAgICAgICAgLSBlbnVtOg0K
PiAgICAgICAgICAgICAgICAtIHRoZWFkLHRoMTUyMC1ncHUNCj4gQEAgLTQ0LDYgKzQ5LDcgQEAg
cHJvcGVydGllczoNCj4gICAgICAgICAgICAtIGVudW06DQo+ICAgICAgICAgICAgICAgIC0gdGks
YW02MnAtZ3B1DQo+ICAgICAgICAgICAgICAgIC0gdGksajcyMXMyLWdwdQ0KPiArICAgICAgICAg
ICAgICAtIHJlbmVzYXMscjhhNzc5aDAtZ3B1DQo+ICAgICAgICAgICAgLSBjb25zdDogaW1nLGlt
Zy1ieHMtNC02NA0KPiAgICAgICAgICAgIC0gY29uc3Q6IGltZyxpbWctcm9ndWUNCj4gIA0KPiBA
QCAtNzAsNyArNzYsOCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgIG1pbkl0ZW1zOiAxDQo+ICANCj4g
ICAgaW50ZXJydXB0czoNCj4gLSAgICBtYXhJdGVtczogMQ0KPiArICAgIG1pbkl0ZW1zOiAxDQo+
ICsgICAgbWF4SXRlbXM6IDgNCj4gIA0KPiAgICBwb3dlci1kb21haW5zOg0KPiAgICAgIG1pbkl0
ZW1zOiAxDQo+IEBAIC0xNzMsNiArMTgwLDE5IEBAIGFsbE9mOg0KPiAgICAgICAgcmVxdWlyZWQ6
DQo+ICAgICAgICAgIC0gcG93ZXItZG9tYWlucw0KPiAgDQo+ICsgIC0gaWY6DQo+ICsgICAgICBu
b3Q6DQo+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+ICsgICAgICAgICAgY29tcGF0aWJsZToNCj4g
KyAgICAgICAgICAgIGNvbnRhaW5zOg0KPiArICAgICAgICAgICAgICBlbnVtOg0KPiArICAgICAg
ICAgICAgICAgIC0gcmVuZXNhcyxyOGE3NzlnMC1ncHUNCj4gKyAgICAgICAgICAgICAgICAtIHJl
bmVzYXMscjhhNzc5aDAtZ3B1DQo+ICsgICAgdGhlbjoNCj4gKyAgICAgIHByb3BlcnRpZXM6DQo+
ICsgICAgICAgIGludGVycnVwdHM6DQo+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAg
ZXhhbXBsZXM6DQo+ICAgIC0gfA0KPiAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9pcnEuaD4NCg0K
