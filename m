Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCBCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B9910E818;
	Mon, 29 Jun 2026 10:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="q0I+DLt6";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="S5xgVx0r";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005D310E818;
 Mon, 29 Jun 2026 10:50:51 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAXnUZ2986140; Mon, 29 Jun 2026 11:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=UUjp3ozdIqxXuM8tducrlZ5oc6tZI9D0+tHvpd+VTk4=; b=q0I
 +DLt6EWRJAJ6jb0pX/cbxoPr6tPO9qjWiWUBozmK4Qskq0WOpcSWB4QHLNVTPf4N
 ibY3wacBUIZgcjknWDE5n+Bxy8onSGnmDFYFIxjuXmvNUA5NfyaVJQGDawNQsrm4
 TDMdlp1j9uyrINcdy6TN4MY8JwJBMPW+WCTLrAU5xd2UFPMNf37xXw+PjTpOqPSa
 /1Nt19/o5mTJmOKwukG3E4RyJzm8sSqsRtIfCZm/LxDoT8ziv8BVo2htDSnPoPhj
 p//P4qa8kBKOo/3YM/Zy60vtFIagtKFYIy/fysXsoyA124oV+abZ8yP6LTCU6SxZ
 M5118YmU2PLA0xczjww==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022095.outbound.protection.outlook.com [52.101.96.95])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snsmsa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:50:41 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSbdigPql7OTbiR0X9HV6OMa9RiCn1rVfnwLthNwzjFf/j5Vl6qn2t1tsX5xVQRK+/AWj98oSPvDu7hckWGFQm607IUYFkyFJC4kXa8oLMef2BAx1C7Jt+3mPn1oRNFddkzVLpOE+i+TKtIiWd+zN20yGU5HGDOG4ZFoltJLbST+rs+ibJqX015sCrv243tR4lk6gWaRK1WI2ia5SSRHH00oGbScA3vRWP58cKbAiySVSwYmNttVQ50Wc2x4xOYyMGd3oIoSW6ZHOMCSGbjQQ+LIip1/saPws8x28vyiZ8HlWuASET0wIFkagWfoDv/JTWrC6lRnu9RcciFM613GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUjp3ozdIqxXuM8tducrlZ5oc6tZI9D0+tHvpd+VTk4=;
 b=GOkvT6ZOTpr1xsXv9McoL3/qclcbFq8SE1TQ4qH7pd3y7bE2dpHxsQH8b3HoKGW5hWvnbE86q5Vtcnewq91+t5ffeFSV+mq00oYQ8wVETwsUrtmng2bXpkZ6tWbvQJ7tqRJjSIWDgzxX78f/+6gh7en1gDb8orSGhlZ7ZKRYMxh4AbTUUNv1B2mprw53Q9QMHrpAD/uLy/E//N+HGcFvwzRSuG6Gw+03AIrp0ZiipiSrAsenW7wJBhhec7Hseyd6IdqJXHqlXHwbBnv5P5TPoFrbfAtsY3H75aQCXmvfSD7ziCqEWoFp9zjH6/8xIMo5Fdhcawwer9R/G5QgK/a0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUjp3ozdIqxXuM8tducrlZ5oc6tZI9D0+tHvpd+VTk4=;
 b=S5xgVx0rWSVAXD3UjoIU/w5lQAunn0Vx0CxVwwADVsTG9DhtTmRGL+y5gqueWGE7vOQEL41vKhEbcoBxuUwBH6KTnk6BM4z4mUDw3vYuIhxb1MfsCq2dxbmmJ1b52kDv7TivdKJcqaZdm2Y39jxZOF6+3KGo0zDSgT5kBn6gGyY=
Received: from LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b6::11)
 by CWXP265MB5225.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:192::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:50:38 +0000
Received: from LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6a13:bb8b:b1da:77e3]) by LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6a13:bb8b:b1da:77e3%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:50:38 +0000
From: Frank Binns <Frank.Binns@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "conor@kernel.org" <conor@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, Luigi Santivetti
 <Luigi.Santivetti@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>
Subject: Re: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Topic: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Index: AQHdBWlojc2/Yy3zQUGOOfGc+NVHJ7ZVX12A
Date: Mon, 29 Jun 2026 10:50:38 +0000
Message-ID: <107e20af63501116a10c34e3e22352d981062232.camel@imgtec.com>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
In-Reply-To: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8579:EE_|CWXP265MB5225:EE_
x-ms-office365-filtering-correlation-id: 8105694f-c3ec-4c94-dd20-08ded5cc418b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 9CAxASSX4yYgAr8GXBR+fbVzDSjvCWDSSg9FhqcIfSodaI3RgJRFsO0Vgg8LXuzCpxkhvr+8exuQuRM/CeXXEUeX63rAXeMMyTJJqWKcW1xiOjLcH1QQa6+2IdQwVGZao94Xx0DeDWM5kgRt5nzBsF1IlLENg3zTzjdScqBF2AwVZaat02yAwCp+Tj8MyNDqvE3KZW9vk8joyXZ/CryTHOTq7ak6svx9r5EWFcn8550a6IP57lKzfgtehsqUKo68H2jH5Szr9OtY3vaQQZxoi/Jf4YCwZu76qfuL7SxzNw5yZGDTaxwakeQgQhXigVfdAzW2mKDFZv0xeFgdBRkgZvXfsi4cUYQ7aq3Ir4tcueN2k7aJOgUrohyjGx2ch00NwzocKTx7f87YhSfeWTjFO0B0ONsmUk1kV68ojRx8PZxE8NB5jJc+Yv68E+OxOXf8eH/PsRMJW3yJPchsidn0L4bFazEtNmmyJJH0NsR//js+nc4g3PpkDndONe+HSLEKjAn6eGw1b1xqR7U9lveryth4y3b1tZ28hX18/M3bt9uNOgMPvdOmZVru1WZwhbo4BG+zXHrU/lfOqNdRGeLtLvojbE5NySrgq1TDBBGAZMGBBkowJ1L2/Kh1A9t3nVXEcUTg4aXsHWMwiR2rfntyPINCtKwJF/yqOSFAWkZ9Ngc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0U1MGpGNm9jSFlOYlYrOHNyTnlPWmQxMllpQzFaTk1jZ3QvUjcydzBvSUw4?=
 =?utf-8?B?bDJjOXZBYVNqVjNYK1k3Qno3c0Y1c1ZyVWlmc2UzbDBPK2cxYnZzd3pMZHJo?=
 =?utf-8?B?UURla2lZSUlONUo1Q0xYVlV4ZVJHUGE4bVN4aVRXVkZ5QnlsSVRiS0pKc1Jj?=
 =?utf-8?B?WTVRU1hlQzB2UFdkRm5Fd0hmUUhMQy9QQWZjbEVIVTRML0QvREpZdUtVZ2Rm?=
 =?utf-8?B?UFRzT3NDNElxMjJRVnlFclpLVVVocjdRVVY2eWxZSi93ZnJZRDVBRGNPaE44?=
 =?utf-8?B?Qk5UZDNYWVdmMFo5VzVTZEc4T1pORzYwYlBaOGRESFEyOTZya084c2sxaGx2?=
 =?utf-8?B?ZGFPd0Q2THRvR2U1cEZHNlJYdzE1MnlueldteGJMQ1RWdXlkQlVvNkhnQzRK?=
 =?utf-8?B?QUE1SUhibnJVUDA0VWZKSjV0dEE5SnVsN3R5aThnK2F5aE93R0t4ZEYrYXh1?=
 =?utf-8?B?OW92T3F5dDZNaXdhTzlkTi9PRDVvUzU5RFBxZzRGUTJ1NnR6SG04TDhnMXhR?=
 =?utf-8?B?Vkk5TnJpcmRFWnVxbDBwMUZjc3l4aWZwNVJMbUtzL3VnUVNlcDFibmk0d2tB?=
 =?utf-8?B?Mk9ST0hTU1E5WGN0OXAxWGJUeDdsMTBvUXpickNORW9wWUFFb3VESWxIOTl0?=
 =?utf-8?B?Z2QrdVM2eG9jTXM3Nk95aDJPSGQ3OGQwS01jWFFpM3pXZEI1QmUySmJyQlJZ?=
 =?utf-8?B?L2l0bDBoSmF3eElIbjYzMDY1azBUckQrOGJvN1AvVjZZUzhtM3VGOTI3eFVR?=
 =?utf-8?B?c0lPUFQ4WXpHd0k1aWd3SWQ1dWdPVG50T0hRdEVNVGQwbEtrMlpibnVCNU8v?=
 =?utf-8?B?Z09kZDN0cWJYV01RSDJDS0t1dXhPLzF5SGlTYkxVQytKQSt3VThMVWc1bm1v?=
 =?utf-8?B?SzI1MEV2MzhuZG8xaE9IVUdTZEF0RmROcCtmMDIxeHllZ2kyUkdta1RVVitu?=
 =?utf-8?B?T0dsclBtNE5XVDE2SDVqUWFrT3h0dTdYMHZwSExzQmJlaVExNzFxZXVEbm5n?=
 =?utf-8?B?NDJ6dGFLcGNEZFlqN083OUVibGJHOEhFUlpjYThrWUZiaC9XS1Q0Tkg4WG5E?=
 =?utf-8?B?Yjk1amdwZGY5SWliUEtxaWowTWNZeWVrcHJhS25KTkFLaG41SGhNRmFWdVgw?=
 =?utf-8?B?anRJWWhlY0JXcFRnV1E4ODZJRGN6aEh6RzIwS2tHekF0c29hRVhSUVY2Uktq?=
 =?utf-8?B?R1Y0WTh2T3RtUSthUGE1a0xtZ2RMVUVrK1BwMDcydkQ1SjdxUUgyeUYzaGJj?=
 =?utf-8?B?T1JYZzM4M2JDb05BTnMzV2ZTZVBHM29qVFVCRnFYbXhEN1VwZEZ4QXRmaGg2?=
 =?utf-8?B?YWxlQlNPUjVDdTZFY21pd0ZvemRSdGIyMGRaUnFhdHg2Q0UydXNZSjd6cWhG?=
 =?utf-8?B?T2VqTXh6YzMrNTA1cUdxS20rbWMvZHV3YlBGTm9YVXBNdXA2M1ZSWXhDQkhI?=
 =?utf-8?B?MnVXY0h1cXVOaWoyWG5EZmV0VVczc0Ntck9VdXh4aE92b3F1VE1Sa2U4Q0w3?=
 =?utf-8?B?MnpmeXdIeWNybHNvNlRzVnFJaGc5WTcwVHhWVk1ZY0tIQVNWMXllS01rY01O?=
 =?utf-8?B?TUk0eUw5Z1VBMU5tZ3NiL0lrUW5aYmJOMWFReit3Rm9zYmZFeTl6cVlUTDRX?=
 =?utf-8?B?NkozUXVZM0xvcnhBRldDZmdyd3IxTFJHUCtQNC93bnArWDhzZjhkbkJaOHRy?=
 =?utf-8?B?TnpsOGtKWnZpdWkzaW5GZldqUVhhZEdoa3BNTThsaFdibTduZ0VpSUFlVlgw?=
 =?utf-8?B?RTRycmJkUFFIQm14K2pMN25idEY2MkJGaDZSd1B5MVNIQzYxRHBCN092ZnBE?=
 =?utf-8?B?WmlrZzZCVDI2YUZkTzk2LzlYTUxrQUJGOGYyVUhmVzdsc2kvVFMwdjR1Um5D?=
 =?utf-8?B?MElJQUZ5ZllBZlRPeUhQVCsyMnp0U1Z4eFIyOVRsZVVKZ2ZZeE85WkU4VHFY?=
 =?utf-8?B?T3JjWE5BdnlPa2kxbDJwUC9NRWczWEk0d3JnWkFiZUJVZHVUM1ZnUG55MVdx?=
 =?utf-8?B?SXg0RTYxSVBqaWsweWNaZWJlTmYrb1haL3N5dVdmbFUvVi8vMVBzNzA3aWtS?=
 =?utf-8?B?eDVrQXUrTDMzZTVWTXZSUVNmTEdNRTFVdE9rMWZZYkp3elpOUlZrUERqK2Rx?=
 =?utf-8?B?YWEvamRPdkFTMFl0Wkc0aXJrL1UyaHZTMzBDRUcxbHlFL05zMUZHdHV6RGty?=
 =?utf-8?B?WHhvTXF2VlpKUnNFT25oSmd5OTRWMVJNL1JFWkZjYUJIcEpKTS9RbTlWUXRi?=
 =?utf-8?B?bWZCRjFpdkV2bjJlenpKYlhQOTNCeXlieUEwRHBCQ0R1dUZSYlNRZ2hwSG5K?=
 =?utf-8?B?VndNbU10OWEybE9ZOWdFckppV0JUc2QzQ2gxT3dGMlpXZHNWVzRPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AF627DBA3062F45937B1061D857BDA7@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wfo/gD8mYPJCJmODbvijhpvaLYhQcGtrl7qzUkEoag/Dl0xXLvZSziKOwBjsVsmuT370p2UpUrZEJdg04ROhoHqKtbGxE8RAILIQv+kmCq7SLxeVYWZOsaXGrkO1+M865CqSXXIWAXAECqPsy5gArsTzSqzxK5sZlTIpU/blvnVtYwl2Ot3/IuUJDvoxtpf0JRZGdybukOiqfhCOzRb3PWKM5SEMXQWT6jtTY5hTPvx49MJe230eBUfOd1UyyU/bYJcbnwuwuKgJDZCuDaSedOtVjZbRCXIa1g8gLt7kDry9Hp6z2bqN2sqDLqVhCX2+bhtrsgKXWKu4Nasabq7iBw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8579.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8105694f-c3ec-4c94-dd20-08ded5cc418b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 10:50:38.2363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lobDIjmv4FUoVdM991rDivp1UDbNigU34+/lzg5y/ebZTd/l8IkAKV2z6uIlWfoOHxpN5rTvRgpj9tiil1oug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5225
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX4f71L2cQPJgq
 TG4gJnbS8lRrnQfxFMBliZKNKTKlTP5t1166oS0bn4GnfZ7n65d/5L+f1HZZT+WAFlc588dJ4YX
 gIQpY3TIWiiW2WJoA+tO3GyjE4iEbh0=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a424e01 cx=c_pps
 a=jZZOmpw0rf31a3f2mMMMOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=oiPMGJNdvW4XLUKoBdoA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: jKqZP3PBcHe7sSMXHfVXOyIfVyXzqyn3
X-Proofpoint-GUID: jKqZP3PBcHe7sSMXHfVXOyIfVyXzqyn3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX9bquSpZT3ysB
 VzoR06V7x+mpIp2rF8Eg2iwg4HB1S2xxAacRzyRO84Yz9L1L6XLf2mAxcawwph4v1PwIwpHI9eg
 Lka8GKbOJ9OaNTFT4mUVbx2KiNDEOf1VmLLMgi7E5V4+L4sN7hUrZc/kUIjDHhT6bnAgW8inNc6
 8uUNQbE0APljSP24W0FIqJbeKJzU5CHZC9lkSwoCwfXpIiSb9G20dChGPK3BjPzd0DyrDfGxkHa
 YzY9HLtiaFrIHuVFtdwD1j9sI+Qz/FNDLwlroAUsg4cpHdWxhTIyNKkXqthlTczv7FrJZMi8Qzm
 rITHnyrKUK90LqGcgDdRf3e0ysKk5JjDon2ItvxAQ2c/HcIf2DS8iXzOrIM4A8XCE7mnDqDJOQR
 sqvFFkAi/Fjzn6Rm23pR9Hv2P7eL8pUCCRqIRQ/ormdNSkShelFNCmgKBNQl154bkL6HmAFyJoh
 GeIW/2PSwrNAUfKUWUA==
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

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEzOjQzICswMTAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
V2UndmUgZ290IHNvbWUgbmV3IHBlb3BsZSBzdGVwcGluZyB1cCB0byBoZWxwIG91dCB3aXRoIG1h
aW50YWluZXJzaGlwIG9mDQo+IHRoZSBpbWFnaW5hdGlvbiBkcml2ZXIsIHNvIGxldCdzIHRha2Ug
dGhpcyBvcHBvcnR1bml0eSB0byB1bmlmeSB0aGUNCj4gbWFpbnRhaW5lciBsaXN0IHdoZXJlIGl0
IGFwcGVhcnMgYWNyb3NzIG11bHRpcGxlIGZpbGVzLg0KPiANCj4gVGhlcmUgYXJlIGFsc28gc29t
ZSBuZXcgcmVzb3VyY2VzIChtYWlsaW5nIGxpc3QsIHBhdGNod29yaywgSVJDKSB0aGF0DQo+IGRp
ZG4ndCBwcmV2aW91c2x5IGV4aXN0IGFuZCBoYWQgbm90IHlldCBiZWVuIGFkZGVkLCBzbyBsZXQn
cyBkbyB0aGF0IG5vdw0KPiBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBDb3N0
ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQoNCkFuZCBvZiBjb3Vyc2UgbXkgb3JpZ2luYWwg
ci1iIHdhcyBzZW50IHRvIHRoZSB3cm9uZyB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0Kc2VyaWVzLi4u
DQoNCkFueXdheSwgdGhpcyBzZXJpZXMgaXM6DQpSZXZpZXdlZC1ieTogRnJhbmsgQmlubnMgPGZy
YW5rLmJpbm5zQGltZ3RlYy5jb20+DQoNCihzb3JyeSBmb3IgdGhlIG5vaXNlISkNCg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBFRElUTUU6IGRlc2NyaWJlIHdoYXQgaXMgbmV3IGluIHRo
aXMgc2VyaWVzIHJldmlzaW9uLg0KPiAtIEVESVRNRTogdXNlIGJ1bGxldHBvaW50cyBhbmQgdGVy
c2UgZGVzY3JpcHRpb25zLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGlu
ay8yMDI2MDYyNS1tYWludGFpbmVyLXVwZGF0ZXMtdjEtMC0zNTExMmIyZjAzOGVAaW1ndGVjLmNv
bQ0KPiANCj4gLS0tDQo+IE1hdHQgQ29zdGVyICgzKToNCj4gICAgICAgTUFJTlRBSU5FUlM6IFVw
ZGF0ZSBpbWFnaW5hdGlvbiBkZXRhaWxzDQo+ICAgICAgIE1BSU5UQUlORVJTOiBVcGRhdGUgaW1h
Z2luYXRpb24gbWFpbnRhaW5lcnMNCj4gICAgICAgZHQtYmluZGluZ3M6IGdwdTogaW1nLHBvd2Vy
dnItKjogQWRkIG1haW50YWluZXIgZW50cmllcw0KPiANCj4gIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvaW1nLHBvd2VydnItcm9ndWUueWFtbCB8ICA0ICsrKy0NCj4gIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvaW1nLHBvd2VydnItc2d4LnlhbWwg
ICB8ICA0ICsrKy0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDEwICsrKysrKystLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA2
MGI1ZmE2ZWRmZWY4NjczMjJmY2U3YzgzMDZlNWM0YjQ2MjExYmU3DQo+IGNoYW5nZS1pZDogMjAy
NjA2MjQtbWFpbnRhaW5lci11cGRhdGVzLWJmYzE4OTI1NDU1NQ0KPiANCg0K
