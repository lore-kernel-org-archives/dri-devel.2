Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F71C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849D410E21A;
	Tue, 30 Jun 2026 15:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="lWLHyfqt";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="eipgUmov";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A3210E21A;
 Tue, 30 Jun 2026 15:58:12 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEHjM21789445; Tue, 30 Jun 2026 16:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=aoQK8SucqdqyeIBAxkbiu0Mpj5OP/ErshxrRUtjHYao=; b=lWL
 HyfqtJtLJVJNwvFVRM9wh2SsVa01vP5NkvtiAD/nw55s2C3WEJzScjW5EZ1JWlxW
 YFuzQ3HW6nBj++OZbwgUPGKGdB01JDHRZgVY4K19tfQZavdRdY4bmSSvlL0wnMj0
 B+gxd0ZAx8OxRaSK01E+oQug7pXRKWm8MMAvBIJt8D7zZrtjee0jt42N7nUB1FTS
 wO3nGeCu5L1pyQcrXmTDaAs7zenfSxjZ/wXvnvd7eiSNEHOmi7EqsNDPnjPQIPQZ
 WO3FujmhgOYLrMZiNddWH0s7Y30WmNnlmbuz2dhQFidFj5SlrV9EBDNMi6Dnx8fc
 pS/adDfNH6UDENczRPw==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020092.outbound.protection.outlook.com [52.101.196.92])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snu2xy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 16:58:10 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBq19lafN3PE828cR+aFb3Mwr5SwmyqRlTq+Zu5Mn43S1LCHB2hShHOXFQ7XZ0lxmEVdtET0azWiMwXpFaWvCb8wdHeY3lic1GbEIVyDQmH5pyUxsZdqsU5DjlpikHyVkAv1CthFHJXrJHTkOdFjp1fdcV2KBMRFs+4GDn7TuP5rG3xWrJvr2rK71GdQ3NA+c2F4Ka5chP1mUhwMNrty2QqyCfgPn6qDskgnOmJTzlT0wGYUomD12aEcYeJAZD2yOEySUXdy9ycJ0MCEm78QGOKlNUQ0pgwCe/Nq8uM/HMYB62utDcafTBc+ROA9VEMc0ydQrVevsCihE+yGNHfyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoQK8SucqdqyeIBAxkbiu0Mpj5OP/ErshxrRUtjHYao=;
 b=KmVkwDzyZFBDZwjxD0k8FXzwl8fdoySH6vQHN7dkOGh73O25NAfRZ3Lux0iyGLiaHxPR46Mv/HAkpDNMKJzk6XT7JzPAb8e79EYTsCmjVVF4x2LbIOMjSX/lEw82SicgcqBJFBy8qifLQlEtRaV17lO9woSopGsd45A/vui21gfGbx3H3sii34tsYjGwvkUij/L9FsxaCPvkSOq9l8YwRzY3BU6AezB1nkRaCT6iHdSdE7z8rAXK8RWyQmH7Ohru7UZsUQARd2u9SUWOum8icZdupQRCN1NeCN0MsPDQb8yLePlvEm1mvMVPZLzFDXpHkpEhmn7EPCO0+uJ1wdhZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoQK8SucqdqyeIBAxkbiu0Mpj5OP/ErshxrRUtjHYao=;
 b=eipgUmov8rFtLPrMJFLuO7xkV5wOmfGAV/oWkXs5nu4lGlN2EWkYB8leb0kjiJo+OgSRBEHM+gBFcdrY+p6O9wR96xt/1jEsIbFwcPBIkxzIFf62mUsafe4mSlZEbfJsd+qJR0C1ItysQCkA0eg0QLIyA9wV3XLyHiAdZYcdrdc=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB0387.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3c6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:58:08 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:58:08 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Remove Matt Coster as maintainer
Thread-Topic: [PATCH 0/2] drm/imagination: Remove Matt Coster as maintainer
Thread-Index: AQHdB96mlK13W8GjtUK9Cdmo8qN4HLZXQr6A
Date: Tue, 30 Jun 2026 15:58:08 +0000
Message-ID: <52241dcdb2b0eba756171e15be0305322649f5cc.camel@imgtec.com>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
In-Reply-To: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB0387:EE_
x-ms-office365-filtering-correlation-id: 08139f00-7c7d-4467-f1db-08ded6c060ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: RwylL1jm95clMxYq8FqLxkgKjzDJhQR1EDjbkBvnJnNI6PdICntmPD5X7kdLMiJ5MPDLd1zjrgjeGlma3nXH8sKL7Va3xmvR/pejLJLNavLxwJNW1zRj/vDSTX+yXbOJz1ytJjjWdNxUuD2Zopr35BJMS+2DI9xB/UzpI+ezhl7G9KVnGpFLH/wT33EX0PWQ35w+yzV2IX8YTBcWl0mekU5+zk35CE5O8fwopiACDQc17ixbRBjBXRsiy4x3i2GMBynnVHlWXxapCeIrQ4VTw0HQMo36fWPb4qkG8cdjBgKgIWSjrg6CFwGCNKX8B9nLt9F/vBJddhuqzduuc/uABWAfs+yomZaJUMcaDLoB5I2ziCnbYN4nd55DjGcsCNlYfv42waW1xFqFplO3Z1bwy5qNGdqUzMBD1Cwvd92nZhl1+ceHzEvxRwptaGwzplDuBr4JhzqaLbEZbMx481DDjtLSqTDmstn7ShjEQOA0cfFugTMVjeft1WDp2zCBttmRJIXnuJ4qZGAZ0lJfZKRCEZkq36qCCuvnimieMkoULHx6j/UH6sqDsWj1XSLMtI56GbWeWlpemfxNcIUyvtzX0UyZgbvrF4L4vsEmPKy5E6WWLvYsbEMzovq6hkZjgYQ+1bpYqlIejXFspecM12/mVZYyIbZzK1EDSF6SUoyLMwqPkz/laBFOl3ckxFG6HLstCueytNhRsf9pxydgZq9Tr3R0GszgGx+wSbaU6XMVHD0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBWYUpNSnhoY0hyZXdkQk5PeXQ4MEVNQlJTTUNESkx2UThLVDY0eHpNZFJ6?=
 =?utf-8?B?RFRVN25zOEZnN2c0Z0VzcTdJUFlLTzVNTFZzMy9ENmhES1psYTRrYm5haHBP?=
 =?utf-8?B?b09ybDN5M2h0NlIwUHhHOE41blQ0ajdndC9KY1p0cVJVNW1tL0NlSFozejJT?=
 =?utf-8?B?Nng3NDlLQURjaEZvZXlScUxLRkRhMnpBd0lHNFhEWS9BZmVyQ2hxTkc1ZmJp?=
 =?utf-8?B?YjhaeTBvYUgzc2NNcHBlQi9KekJpazVoUFphRWpQN0taQTBudFBTTFFKV2ZR?=
 =?utf-8?B?VjZHdTA5VlZKRGtYVGhJUnVNUnpDZUc4cThheWw4OVZNNjZ0OXZjRGZvazc2?=
 =?utf-8?B?TmlGZVgvUmJ0bk1hdW5OdmFxcmhzUkw5SXI2U3c3TlJWbWFQMkJzSmhkRWF1?=
 =?utf-8?B?WTFJdkFxcFRFTURLSklJV1JoVDliTWtydy9sWm5TSzcra2NxanNMbkEzNVB0?=
 =?utf-8?B?OXpDcDVkZFhqYjNkbjBZRzRVdjV4UUtJdFB5enUzdS9XaFB1dUZKRURyL3pv?=
 =?utf-8?B?VnozSWlTVEsyNE1aNDlSUWRPcmxFUlZZTVA0OCtTOCtkSzF4dlVxaVUrOEE5?=
 =?utf-8?B?eGszcFovMGNQU2hjRjh0V3FsVGJiQjg2bnlOSFB5cjRHbU5sYnFXT2dxR3Qr?=
 =?utf-8?B?SDM5aER1dU1HSFg2NWVxRFR4cWxWN3RNcmtvUVFvNWtyb2NDU0VwUERkRmVh?=
 =?utf-8?B?Y2dMVy9VaXQvZkE2NlNLcHdwM1cyK3phdkIxQ1RHY2RRSmplUy9zVFFIL21z?=
 =?utf-8?B?T3dlbjY5bXVGVHRUdzJjTEFQSFMvbmVTMG5OdEh1cXNVRDJPSWlreUd5Y0Qv?=
 =?utf-8?B?OHV5dFhRaG9vdUpXcXpud2xNRHpNalJNbG00cTYwRXdFVHA0QldZOHJOSzRP?=
 =?utf-8?B?NnhwRDJRZ2ZSVE5ueFBVMGJpd0ZoSk5GSG52TjZsU1RqS01XSnJJMXRzcmNY?=
 =?utf-8?B?UDZITTFvTm1vR2wza0dLbDBjNGdHa1cwVkdNUVFNbm5SNGdNdy9rTGVCUGY3?=
 =?utf-8?B?UE1iSUs1TEhKWHVobUNQejAvSktXOG5zTzVLNllsTElBby9HbEZNSER0ODVy?=
 =?utf-8?B?aWhLYzRoT2NQT0RFVmZ2bU16ekgvRkVOTEdCWmxFK2xLOUpTMGJRVDJFWERM?=
 =?utf-8?B?WnVibHdIa1ZhS1Z1eEpOckNlVndzN1R3d0ptUllFV3JZc2xLaEh5dWIwWlJU?=
 =?utf-8?B?UW5VNnFvdUVDUU9jMXJ0M25DcWV1SkV0TVFMRkxVMzBQMUlrYmlienJRRkNK?=
 =?utf-8?B?OHlESUpVZkxVdjhMdVUvaFJwYXRtZE1hWmVPc2Jtei9ad3JsdjNtaUcrZ3pC?=
 =?utf-8?B?dHk5ak5ZY0NhampuRnFQaFlMNkhKemVMTC9xb2U5K2FjMTI4OEg4SGdyTDZ4?=
 =?utf-8?B?czNyL29KRllnWnhESGJmN3Znby8xblFQVy9PaG1VbHlUZTJuMnlUanU2THYx?=
 =?utf-8?B?Y3B4N3BZUCtIbUh3OU1GNGRvd2IzUEJQTW1MV3VyS0phS2ZERDNBL2kvd1Zp?=
 =?utf-8?B?Y1FyY2ZoZXgxV1V2NkE5SWhHTjJaaDl0UmtSMnBXeEJWM0lJN3dUeVNsSFMv?=
 =?utf-8?B?VTFCYXRkQU1xRVhBM3ZveU5RaG10VEJ2QUZwQmpaSVl5K3U0QXM0dkJUMmpF?=
 =?utf-8?B?dTFwMDE2Y0hobkdyeWJIZzdZUjg3bkp6TDZ0MC8vRzV0L2FGMGhTZE1xdjN0?=
 =?utf-8?B?K1lPMmhtV2lyS2dXTDh6TURUWDlvZzZaK2ZJQlFBaUR2LzNhL1dCZ3FEZW5k?=
 =?utf-8?B?Y1dDUnhybTJ2U0pwYWc3alpwWGorZEVlNmRWN1ZjQ0Noa2R3eXRsTWFVY0tN?=
 =?utf-8?B?WGo0ZlF0Y1VsWUd6L1VUYmVRdEF2bFhIYUJWTGJCUTA3eVVaRmQ1Rnh4cmVt?=
 =?utf-8?B?VS9KWWo0dU4yeHhsT2FHeVBNN21UMHoxUDRlU2hvZGUvRGgwMXM3cmFYU0xQ?=
 =?utf-8?B?d3dhT3ZoKzhCajNETTVLaHBKU0QwNjYzL2l3WUhkdDZFd3hWcjdjU2w3U3NO?=
 =?utf-8?B?T3lBVUd0Nm4vQnJMdjhJNXgrVzFVT0cvcUhSQnA3R3FBclM3enNOeG1TaEZu?=
 =?utf-8?B?V29EYUR5Y3hpMjJYOW41SEdVRldoNEpHSHpaYnFvdXg4bDN6eUZFWmtMZy9w?=
 =?utf-8?B?TEswZWZiY29rVlhnbzdxZTAwRWFyTnczRUlNeFlvOExFSWlyNExDMjJZTnNB?=
 =?utf-8?B?NE9NaE92amFsK1lFd0JzWGFXUFZqMCs3bk44OUVKd1BlNmg5KytUWTZ4ci9Z?=
 =?utf-8?B?N3RxTCtZUGF1OGtmWDdXMHNIU0RQa3hQOFZKZzVCRWRzNHREYjZVZEdRenA3?=
 =?utf-8?B?aEd1cXFqTkVFREpiMXpCM2YwR09EZ3dGM0RiNWNxYlZuY0trOFNydmdBQVZq?=
 =?utf-8?Q?Abaq2FDOpOZtFeF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68400AED3E71D744936A30D3667C6156@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gg4lok1GnGanajFDoS9eYa4UjufCmWDAe0e06fZ5A1jd5FrT5ftQvszMFump/6tZMeOJmENZoNH7/XkeqI0PXfGM61x9rf9QLydo++ejYaimJM8i5eo/xcUMm2sMxJY1z9lEbw1cGn67tLcweX3OOFDWhP+TEVuObfAjHKpLkzSrxMJjNOGEjmyMr7oOUrHMO72Wuj7KIR51H8Dkegw7TVNnGRup+zhLtSfm63Csy3Cc0/XjXxSupB0sqJfnV2wgAh2DH3INEFQ7It91qkgGEveQ1TNMzJvfFgG23wLdh9oPss/Ouc7sY+NvO8EePcVwSrqaZTiEePBivbzie7yd8A==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08139f00-7c7d-4467-f1db-08ded6c060ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 15:58:08.1554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IgKRVE1fQKPppxug8Ciuw1U8qr+sGLY0ZBdzzX+6R8Ee0cDQnLRLLEb9Q0SZ9UOzagvxqY3ocjphYimxf1Yo9o5/9Vby8LQsJc4nVYThuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB0387
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1MSBTYWx0ZWRfX5SQjkNeZtHkP
 pzagi45Oku5O215SZj9v+i5orOd0n/Jp1Kvnh3OvcziZrqqHRcKKuFkmecxgUAOdBV4bpfpf1Af
 T48KS712pnqrExsmfpy3ujIY7kGQDJY=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a43e792 cx=c_pps
 a=RSRWZRXCBcETl5wMG6tcpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=NwBMHlxDzWVq3sCcW4cA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: bRgNibYAfL9Y823M523hqAVNSuLPc6a-
X-Proofpoint-GUID: bRgNibYAfL9Y823M523hqAVNSuLPc6a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1MSBTYWx0ZWRfX1lsO1/+07Wv0
 ss5yvegRG1qAvvzIdys/5cLO2Yytp1U/M/mlK8P/VZY1Z9ELdUIGx7bymSXaCZvXMat9zc8mPGe
 cYZpZpDoxL++aowZpIVEeSCxdm8nssw8dYqK5KM25N9RjegcVUnzHidzZJVtai4T6pR1n+Ye99q
 YVA4RXmiBtb+tp1acuExNkmdzHzsOtJoWXYrEStJ2G0CJnrGFZfEgIktV7yJ05VSeIV9RWWOqvs
 Wzwfrt8V1WoJzpDPpzShDubQp8IYqzK1sIKFWzUOhXZm/i4RSdh2hEnVVQK8J/LC5O5YySao1NF
 DN+RBiz3e5Wi5iqsxzqbVXCMZJ8JvXnjENbo7kONyUW9IxQmiROIOVzH3ABmLAOEDyi+mTD++pl
 CUGuPmV1tc7FdskflBHkMaBMYiQS5qoYzKc/8mpQivZ/ahtNzmquNs+QSdStaR5ykRmehN90LFL
 bf0S12LCY5vLqGkpAag==
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

T24gTW9uLCAyMDI2LTA2LTI5IGF0IDE2OjQ3ICswMTAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
SSdsbCBhcHBseSB0aGlzIHRvd2FyZHMgdGhlIGVuZCBvZiBidXNpbmVzcyB0b21vcnJvdzsgbXkg
bGFzdCBkYXkuDQo+IA0KPiBJbiBjYXNlIGFueW9uZSByZWFkcyB0aGlzLCBJJ2QgbGlrZSB0byB0
YWtlIHRoZSBvcHBvcnR1bml0eSB0byB0aGFuaw0KPiBldmVyeW9uZSB3aG8gcmV2aWV3ZWQgbXkg
cGF0Y2hlcywgb3Igc2VudCBwYXRjaGVzIGZvciBtZSB0byByZXZpZXcuIEl0J3MNCj4gYmVlbiBh
IGdyZWF0IGNoYXB0ZXIgb2YgbXkgbGlmZSBjb250cmlidXRpbmcgdG8gdGhpcyBwcm9qZWN0LCBh
bmQgSSBob3BlDQo+IHRvIGNyb3NzIHBhdGhzIHdpdGggaXQgYWdhaW4gaW4gdGhlIGZ1dHVyZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29t
Pg0KDQpBY2tlZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0K
DQo+IC0tLQ0KPiBNYXR0IENvc3RlciAoMik6DQo+ICAgICAgIE1BSU5UQUlORVJTLCBtYWlsbWFw
OiBVcGRhdGUgYWRkcmVzcyBmb3IgTWF0dCBDb3N0ZXINCj4gICAgICAgZHQtYmluZGluZ3M6IGdw
dTogaW1nLHBvd2VydnItKjogUmVtb3ZlIE1hdHQgQ29zdGVyIGFzIG1haW50YWluZXINCj4gDQo+
ICAubWFpbG1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxICsNCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvaW1n
LHBvd2VydnItcm9ndWUueWFtbCB8IDEgLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1zZ3gueWFtbCAgIHwgMSAtDQo+ICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxIC0NCj4g
IDQgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogMjYzN2NjNjBiMGUxMGRiYjc3ZmJjNzQ5ZjVkMmRlMTBhY2YxMzNmNg0K
PiBjaGFuZ2UtaWQ6IDIwMjYwNjI5LWdvb2RieWUtMjY0NjhmOTUwMmI0DQo+IA0KDQo=
