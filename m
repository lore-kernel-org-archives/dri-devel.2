Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E4AC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6F110F19D;
	Thu,  6 Aug 2026 12:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Icx27cns";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="OpirXe+s";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D1510F19D;
 Thu,  6 Aug 2026 12:04:50 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6764K2i13793545; Thu, 6 Aug 2026 13:04:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=imXcIEpFzYymhkUe+6EfPBKVwsKOyRYa/v//oJOE/o0=; b=Icx
 27cnsMw4eAxjcCewRpYj530lYBEC0Daw7nRJIvW9mZcUzpdO08pOg+kyV0+WcQrc
 na+5sOWuxG3rjTS0IKefa9167Kvidb1oi7VHAqQw7I8hD0aUG6mh36ntGiZukk8Q
 Il7k/Mu5ApCDfXckpu3C3KEJ1sxSC1m38LtegtEN6GAw7tNhqFkRgEXNiN4cfywH
 a62NPYS4B9pGKtrzJBfQbIbzgk/LgAtsBsR1pPAHHF8eSAK0G/b2S3Z24qo5A9cU
 PDUoOMqMq0YS+MC2xQsmKwTP3VxW4s0DCHybjG2XYncpI14gIdpT0yixwm2D/bg/
 4Y/joIBOLCDEnlZMwUQ==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022081.outbound.protection.outlook.com [52.101.101.81])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fv7vyh15v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Aug 2026 13:04:40 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcixKELtaLb1JhcIr6YEIPQwNAjCyHStsEUKRlDwxL2P6ZHLIoGQBt9u+qBEiI3duTtTw2MbanU6us5GKpBNKo98I4Ohv9S15HC1oOQbCJ0qMS2oVXtC7zxBwnUkEOGXBc6wdq1N1i3Vf2PHOXX94sJB7UM0wM8YTsTn7K9H3R/w+KEvDf8n/EscZVN8w+6enKVVUo7e3TzBvdL1VY0+6IX6UJT91Omd0WgfqJvNMDViVALJkNs5Dvn6qmxEUze2eJI7bwVQZe3vT4WvpZzGInUk25sFDihTYLuZDLSGITktEu5Lp3wH77Tqhrwdtr7/fijHzZQthggangTGkIfcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imXcIEpFzYymhkUe+6EfPBKVwsKOyRYa/v//oJOE/o0=;
 b=nBf2H0B1/MIux1HVPyWNsodc36TXbUYtg4OaDJvlDmFdCBUl+7f9UCXOsfK4zTv6y2Jgi918ZgJWjfsvHSfUM2tlyWv/SXfWkHSzXwWpL5Ih4of6+hyMbq832bkospnpxcOavUokY1liRpRhUkys+QJj55sSaUve08IeUmsFeHT0e6ZGXZVDXcBJP4XkFRgaACLreoU/EE0AcU4Jky0ATutDCqNH4s16U9egbz99oFIK2j7nF2NxclLMrEC6uV5UeOBRVkJnCCo/2HHNDKVQsJftEouJ2DcGJHU8egiyT8jkYKEM9n2gu2HLEZRC+MSsv7TNFfA2jlYd7CQw/Yyx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imXcIEpFzYymhkUe+6EfPBKVwsKOyRYa/v//oJOE/o0=;
 b=OpirXe+s2p972tvhnVUMhIIlQRFwQn0g5SCyCBjRa8oIfBV8QxTPx07UqL8Gi75pOnKKh6sCLKnzmE4GyB1YeOdMmVF8r1+mDJDZjMV080fF2vBr7jViXmpQ9LJjc87BaYgA+sLYBw69aDMwH+aqcykrzKOrnykInFqMjPkreRQ=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by CW1P302MB0849.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:248::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 12:04:37 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 12:04:37 +0000
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
Subject: Re: [PATCH] drm/imagination: Explicitly set CACHED flag on META FW
Thread-Topic: [PATCH] drm/imagination: Explicitly set CACHED flag on META FW
Thread-Index: AQHdJBeCX1C4I1WLPUKjKDIjfZ5HeLaQ71AA
Date: Thu, 6 Aug 2026 12:04:37 +0000
Message-ID: <8b616916150b9ce2ffe0dc395b7a0a4902efa693.camel@imgtec.com>
References: <20260804-b4-cached-flag-on-meta-fw-v1-1-333bccf10d3a@imgtec.com>
In-Reply-To: <20260804-b4-cached-flag-on-meta-fw-v1-1-333bccf10d3a@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|CW1P302MB0849:EE_
x-ms-office365-filtering-correlation-id: 21064d94-665f-44ab-d1ad-08def3b2e317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: OFJN3vNbBB5495HqkFnXAXNDkd+c801Ockek+tTrlQYHlOM2M0XOiI7ECsv/Js8U0zrQAu6WrtaYvBbTfkr0X73pSKdMq6SUg1JejC/4UawkkfRfdObk71GJNZE7xcJeoQRFi7NuElk8wewIOqvmET/YsTVHAvPAJLqxAf4mEyU8+38xeGN5vIoje1mm8sMAE961gaFbelI76TR3YwpjiaE3e+KjbiXv6HMwwIrImmbCl39v9JMBThRS/I6WXlC6TltRocUqzQXxUSysjBUx9DoV9zhXT+7Vtz2F3LsK2F/IJhZns6Ggqwx5WqkyCM7PDVTbrWHvh4iQ/gDVTRQ4c6Vmju0/E06fafXi4Jy5VMedpfLSUk6iUo2fcXfWXNcF8GQng3tA91IXVyAELjjP3vxtCYwlAVgCYo+0wFOVbZ5rQklHskP4S8gao8YFpFGFw/qkCjb4FdMwzmiHBsU0H9kGrK+bO/l8bWVLCqiRQ4jONwgF4kNwkgOhpF5Z/r9AtSD1iaRy8cUKy4MN+JTVWnRn6HSRq395YDDOOKHVauu8CLtUTGafN9ddKTIPIB876FUs6xpquVxvYvjUoFPpmHNMAFgNXql8n5fgjMP4az0ZfRGNQsAK0/PNeFJCIA4p8kJ6Vi8KKvu0qvD8MLWvfOnc542ycukuFNz1lj+UBnLIND+zGlqI5CQTaN8sxLgJ4jgJdBYcIz9FZz5bwsmeIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBHcnNqOG43WUd0clhYMFE1UVNQQkZnUmlITDZvc2pLeFVnN0VRWXlUeXV0?=
 =?utf-8?B?elU3VmN0MG1iMUFqUmVZeENYdE13LzkyVGF5RlQ1Wi9zaXZxN2xJbGVsVUxs?=
 =?utf-8?B?MUlsdjZmSW5xeVNCTkVCTE83c3FVTG0zS2d0UkNvWXNUZ0NQVmpVNWlLTnNa?=
 =?utf-8?B?d0RVWXpGb3FqNFFNbW5RRHkwV0NkZW1iOFE3NGhMT1lubWYzS1RzajF4QWhU?=
 =?utf-8?B?UGpwQ2pRcHpnbCt6Sk1SdGJqSTJjcHNlSG9FU1lNWEUxRitURC92RkNVcFNO?=
 =?utf-8?B?Z1ZVenBkYUNzOEpHZnpOSmJna3JkdnBVQXI0WjZVUThqSGhoanVicFROTFJa?=
 =?utf-8?B?M29laE9pK1lXSHBCZ2h5TWpNSWN5bGhUelp5RVZPWTF5Nlo0TEtFdFhWTHdL?=
 =?utf-8?B?T1dPMXV6UC9OQWdWdEtFVDlDenB3dlpKKzVMZDJtVGw1cmdWZTc1TFpaTmpF?=
 =?utf-8?B?V3RDNU1MS2RrREFqU2wzVHVjNGk5MlBaSWhKNEp5Umt6UE1rbnE2NWdRUDB2?=
 =?utf-8?B?TE5MN2JOQTdNR1dod2dvWTdTT2xZaTJ6QTJLK2NWa0V6R3BQMHQxeUl1TXdw?=
 =?utf-8?B?MFp3eUpHVytnWmMzd1pSSzFzUldWT3MzMFQ2dUFHbEJJYUJQZmFjSS9sZ2Fi?=
 =?utf-8?B?aGZ5QzBGK2tyVFdSd1V3bWxoanZiZ3pxM2E5MHc5VUhQTVNCdzZHNVoxb2VK?=
 =?utf-8?B?N2hsSFNTM1l2K3VYK2h0MEEyODlibDhWUmUwY1UrczN2WnFjSmxzM1hHNWFx?=
 =?utf-8?B?ZW9sSXl0clR4Wnl6ZFEraFR4Mk91MVNYakczYkNJdjFDNzBTVVdORlYvTll6?=
 =?utf-8?B?SnFYSjkwS1hROW1oeUNHQU52dWxzazRRc1ZOaE9aL1FMT3JkU1c5WnRUSWxK?=
 =?utf-8?B?cDZzZk9PTlNLdndDMEJnOGV5TElUMklpOTUvNEIzUCtoR3dBaCtHc3loVFhq?=
 =?utf-8?B?L1JqUUhXSG1qaFAzNUtWdEZnVVhuam9idmJSQU9LWnYzbDkvS2RtcTM2K3Zj?=
 =?utf-8?B?UkpBM3BPWHpMcUdBZ053b09sQlJTcWlIWWxaV0NwK2FKNm5jYTVrcitQWlRX?=
 =?utf-8?B?S2QwN1JmUE54MjNtZTNIYlQ3ZG1YbTB1WDZsakdCWkptK3k0NlJaWXNEdGpR?=
 =?utf-8?B?a0ZxUjRnRVRDZSsyMDMxaCtZRlZjSVFZUE5MVHJsV2RGZXJqVTJSOHJtcFZm?=
 =?utf-8?B?YkVxaml6UDE4NkRhYzMrczFMZGJHZkRGRHRBQ2JXK0o4UndjQlZKS2ZQSXk0?=
 =?utf-8?B?bFBZRGNva2FDcFRXV3VGQ2drcFBtTE5DN3oyaVcydURPbzdWRmJ1Q2VtNWJw?=
 =?utf-8?B?UE1SUXcxbit4RUd2dlFCZnhWT0U1QjJFeER0L3hMM3dpaEhwT3VSbzQwV1dk?=
 =?utf-8?B?a0hXa2k3RTJoLzJmQXVlNGROQ21kWCtKcGdQV0lUTjdqaGYyQzlvRXlqdkNG?=
 =?utf-8?B?ZTZ5U1E1QXoxTFR1SFNEbkdhS1YrMzF1RWxXQm5vWjQ0SGZxbG85RXNEREJr?=
 =?utf-8?B?OHRjMlh0QlRGV0piVmJ3UUIxVC96U2VJc2htaktDRWpMUmNjSkZ4MVd5VXhq?=
 =?utf-8?B?aWllN1JiamNlOGZhdVZnMUlBTG9iTFhJaVVuMUx6bVRqU0Z6ZTJ4QnRHYVBs?=
 =?utf-8?B?VUZXcWJBTllFN3VhWnZKS0t4c0wyeFpkemV0NVQzN2E1Yk1qbkxVZGd2MVU0?=
 =?utf-8?B?ZUl2NEZnVGUyckN6RFlOQkJvZG55dHJ3VGZtV0grbW1HWlNSbnArMGl5WWhv?=
 =?utf-8?B?N2NqM2hsOVU1Mkd1SGcrN1pkZkdzbmM1K0pIYWltSXlhenhaRHNCZ2dNR2xC?=
 =?utf-8?B?OFhZNXFrQzhFNUVKR2hKbnI2VkpERVFvSjZlNzdUQjhZSmwrak9OYTlmNUJi?=
 =?utf-8?B?TDBsSlo5dTVxR3kxaUNReXpBR3EvTG1USVlDRis5UmhweFFSTEg2bWMwV0I5?=
 =?utf-8?B?UGpFdFNoWXJnSGg0VlhHT1hkdXgvUS9aNE44Q3RCSGdDaEowQTNoVWZBQzNi?=
 =?utf-8?B?L3laSlhGZWVNNDUwV2VHUkM5MlFhc1pVWUVpY3dYZzFqL3VuNlFsMEhBckFP?=
 =?utf-8?B?YW8zdWhzQlRmU1E1d2daclVIN2J5ZTc0amRidGhjUGdnYVdEaUVFcUViK0pD?=
 =?utf-8?B?cktZUnIrYW1yc1RocENsZW5Hd2M4OEhjamZTSEF0bWRRc1N2ZUZrN3VqYnJ0?=
 =?utf-8?B?OHN1YTdzSTJJYWwxMHk3THhmS0xMc1RXdG5pVE1QYnRyU0EwTTZIUTB0cTE0?=
 =?utf-8?B?Z05UTm0zRkhhZ2hBMVJpRFdUQjZZUzFhMDhldWxmRVBJSTRqYVRRZEQydkgr?=
 =?utf-8?B?dTlYWTl5RGRBejlsMW83TkxRZVE4bWdlazliYUQyWkU2VXEyN1BtMVBHMkpF?=
 =?utf-8?Q?GvY5eXoBJDdQhFcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41E7D39F5335984DBF565456E1AC32F9@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ka+STHfbEuj/B6FuwxLoPVbsf7KyUMd5lMmorkVcu1j3A4uYIzovAxF/Y0pPzGc00MvA3IYAUX9yg/c/72ulLyOwpoojPo0ekKCyQeekz8Sowt6aBOKPtnDmvYW5Z9V7uI0/Owxv7erYkYO6UUywknfFIz6NUWIFihKhKzLsJPOxAm0/xNoWh7BwtUrmX1tGNX6w/h661+j+E9LtDFXYZHOO4L3hSX4GY0rtnQTFaOkucwtZacTxaK0N/8hZlpK9kfanmit26MtIZX9fnUnWPBB9j86msLNioL80lGlmF7jHxIXAWHb/RfqKeCkGl0MMyOMOXDz2ixYGFBQ1ufkoTw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21064d94-665f-44ab-d1ad-08def3b2e317
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 12:04:37.2548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SH/Q2K4kLtPNczDBjUAy9hHw7mz1/MZbb7wAkXafWgyZ20tHMm8P73OmnQwSfp/xuQLJWC4r7ofNIJm/Gf5aCl296BUk6y+jlhD+/PCFnho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P302MB0849
X-Proofpoint-GUID: e8-w5axFtYeWJA7ma9JQVors-67NFGL8
X-Proofpoint-ORIG-GUID: e8-w5axFtYeWJA7ma9JQVors-67NFGL8
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a747858 cx=c_pps
 a=sa1UTF+hF9ngSwGmYD9zsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=iB0s77fEAAAA:8
 a=r_1tXGB3AAAA:8 a=xrgio8yv_VBHdxbv7PoA:9 a=QEXdDO2ut3YA:10
 a=HyUCkmmLtCL0fD60kmUx:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5NCBTYWx0ZWRfX8yKmpasfCki4
 SKPnElzlr2owgKws1oEe+aEe9unQNYKWnz6oGpkX/V/MohaW3CGn/wLLAj1uQPLYnYlq3XCG3vd
 RDeESVARmZI1BfxnnHE97VDN1DajlcNZHU9wOk0pWgiEOiiBsrMxUgqGMWG96XhV77sEgPUsA2c
 EF+38hGvwwAfRNTfICuems+kN4SBGBlCgopynjDRFCa0qvryP8rvOCva9CitKJVoHtNGW+Rl1cY
 rbILgEfXlu2wd3zmM/hn8uzPosbR9jZA1GWjPN3qR9JOgVEdv1LKR6XyZylDj0ZhDEjZM0iiqlq
 t2YS9COyweq23sP6KlIxf8vOVpp2w5RYz10Rl/IjRMWod+JewghFaPhFw6spJfeSVqJU/UXIR0Y
 viDDHFhyHyNWYxvCCmxx3BFi/XRyN2cBRmZDJCEd/QQPGkHPR2tClogsq5zPHEY0TY+SUmnGbV5
 +PV81iNcziAljv5YohA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5NCBTYWx0ZWRfX5cxt7FRBZNLF
 6iIaue0pdPEXORlJjpCTh8OTtCl2iOIf96vWmbMjgJEbWGtA8rk1dxVvawj+twCgA/KGYtGLERa
 mRU7ECvsiAribUEzXpCvXmx0moGWKks=
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

SGkgQWxleCwNCg0KT24gVHVlLCAyMDI2LTA4LTA0IGF0IDE2OjQ1ICswMzAwLCBBbGV4YW5kcnUg
RGFkdSB3cm90ZToNCj4gRnJvbTogTWF0dCBDb3N0ZXIgPG9wZW5zb3VyY2VAbXRjb3N0ZXIubmV0
Pg0KDQpUaGlzIHNob3VsZCBtYXRjaCB0aGUgU2lnbmVkLW9mZi1ieSBsaW5lIGJlbG93Lg0KDQpE
b2VzIGdpdCBzaG93IC0tbm8tbWFpbG1hcCA8TWF0dCdzIGNvbW1pdD4gcmV0dXJuIHRoZSBhZGRy
ZXNzIGJlbG93IGluIHRoZQ0KQXV0aG9yIGZpZWxkPyBJZiBzbywgYW5kIGI0IHNlbmQgLS1kcnkt
cnVuIHJldHVybnMgdGhlIGFkZHJlc3MgYWJvdmUgaW4gdGhpcw0KRnJvbSBsaW5lLCBjYW4geW91
IHRyeSB1cGRhdGluZyBiNCB0byBsYXRlc3Q/DQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiANCj4g
Rm9yIGNvbXBsZXRlbmVzcywgT1IgaW4gdGhlIENBQ0hFRCBmbGFncyB3aGVuIHdlJ3JlIG5vdCBP
UmluZyBpbiB0aGUNCj4gVU5DQUNIRUQgY291bnRlcnBhcnRzLiBPbmUgb2YgdGhlc2UgaXMgcHJv
YmFibHkgemVybywgYnV0IChhKSBpdCBpc24ndA0KPiBldmlkZW50IGp1c3QgYnkgcmVhZGluZyB0
aGVzZSBsaW5lcywgYW5kIChiKSB0aGUgY29tcGlsZXIgd2lsbCBtYWtlIGl0DQo+IGRpc2FwcGVh
ciBpbiB0aGF0IGNhc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0IENvc3RlciA8bWF0dC5j
b3N0ZXJAaW1ndGVjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhh
bmRydS5kYWR1QGltZ3RlYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9md19tZXRhLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9md19tZXRhLmMNCj4gaW5kZXggOWZmMDNiYzYwYTA4Li5iNTgzN2JhNTZlMzMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfbWV0YS5jDQo+IEBAIC01MDks
OSArNTA5LDEzIEBAIHB2cl9tZXRhX2dldF9md19hZGRyX3dpdGhfb2Zmc2V0KHN0cnVjdCBwdnJf
Zndfb2JqZWN0ICpmd19vYmosIHUzMiBvZmZzZXQpDQo+ICAJdTMyIGZ3X2FkZHIgPSBmd19vYmot
PmZ3X2FkZHJfb2Zmc2V0ICsgb2Zmc2V0ICsgUk9HVUVfRldfU0VHTU1VX0RBVEFfQkFTRV9BRERS
RVNTOw0KPiAgDQo+ICAJLyogTUVUQSBjYWNoZWFiaWxpdHkgaXMgZGV0ZXJtaW5lZCBieSBhZGRy
ZXNzLiAqLw0KPiAtCWlmIChmd19vYmotPmdlbS0+ZmxhZ3MgJiBQVlJfQk9fRldfRkxBR1NfREVW
SUNFX1VOQ0FDSEVEKQ0KPiArCWlmIChmd19vYmotPmdlbS0+ZmxhZ3MgJiBQVlJfQk9fRldfRkxB
R1NfREVWSUNFX1VOQ0FDSEVEKSB7DQo+ICAJCWZ3X2FkZHIgfD0gUk9HVUVfRldfU0VHTU1VX0RB
VEFfTUVUQV9VTkNBQ0hFRCB8DQo+ICAJCQkgICBST0dVRV9GV19TRUdNTVVfREFUQV9WSVZUX1NM
Q19VTkNBQ0hFRDsNCj4gKwl9IGVsc2Ugew0KPiArCQlmd19hZGRyIHw9IFJPR1VFX0ZXX1NFR01N
VV9EQVRBX01FVEFfQ0FDSEVEIHwNCj4gKwkJCSAgIFJPR1VFX0ZXX1NFR01NVV9EQVRBX1ZJVlRf
U0xDX0NBQ0hFRDsNCj4gKwl9DQo+ICANCj4gIAlyZXR1cm4gZndfYWRkcjsNCj4gIH0NCj4gDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogZTU1ZmVhZDIyZmY5ZWUwNDdhYjlmMTkwMzg2MGM0YjQzMDQz
NTE0ZQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwODA0LWI0LWNhY2hlZC1mbGFnLW9uLW1ldGEtZnctYjBm
YjI1ODliYTcyDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==
