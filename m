Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CBC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB8310E66B;
	Thu, 30 Jul 2026 08:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="lYz3AyNa";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="KN7RC0fJ";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815D210EE4E;
 Thu, 30 Jul 2026 08:28:42 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U6cN8o2847187; Thu, 30 Jul 2026 09:28:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=33fUopuxdjcJxrb9Vn6ILP68MjssEep9wI8Pb7GDX30=; b=lYz
 3AyNamol/kOyjg5iupZ6yduMILAg7XKINwQD44hP3AushDZH7zpk4TprY21ju2w+
 6hr6HGB7CLc+9MUMQ8YxaTB1+L07Zk3V2rMYLpXXLARKSpeF6E5FJtJ/ZwfhrUyB
 7QeeK0Atxwr95PIOTCKnkDto0L7BZaIF7haK0bcqUXIypFB3L4PCUfzNTscGGfcT
 UpmG/HYY1st2ps3LWj7v8HdGZpQsnbfCo1Gvy4ecgShdgVFJ4T/Z653dEezeIheG
 JpY+85OpifGA8RrpyULUPtQ2A5OSyh2vjihNjMXTV8F8z/QTIITJ06+X7/fS4U27
 UooPwgTtP3GH7xQ38uQ==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8s1s5n6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 09:28:28 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+a6XEOKcfJgz7bbaEkJsqyiy6rMF8W3MULa/JDomfK2j9YEzKZTThFABcvt9wVTBQfiMDpzknAOsD+T2zDM4+lR1GrqGVqiOQ0UsCiOHqG+lLC3ezJb5OEi1jYSeuJh3Ijad/lymRCUS3MmCFeLSTccrmiYtHc5v6S8nKIL1TFVEjs8thdn3dJqu8FzZazw8UrUdy1vD3zHNlsCSuSieQwRsbpI+0KqAVVzk4Hb1ghiPapz71nTNn5pcwZQ9aVq5/t70mmht67+AYzLAPl7tbX7X0l6oEl32kuJm+dX7/kFPEyDHSEhJrSTyfLjlVNI7ii27znZGG32U724jNiqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33fUopuxdjcJxrb9Vn6ILP68MjssEep9wI8Pb7GDX30=;
 b=LjSXORb9cwrEPXG9O1dlmerXo10tCchBkkYeXpfBGJ7hKO7ytGwiBw9ZGTJtcUaPuEnnEfjNOzHfw1VYvnanDg90C6dgyx+z5MpHng178tAxxTV6LLbzVndy7ShJxjlg8m+oIzU4r5H5lHZkplrDU9HsNWdiYaSi2u2KgKk3afHGtGe2bp7edE3I9NIAz1p7uWpA6kSlKar9y2pY2daUSkJszg3ozOZ5gkVFBm5SZYDFrpUKhcOJp34HbWuEZIZDWOvU+R1zntF8g0FNiVj/tsfLFJtTi4hH8NmFVej1UCgvbk0obLnuWpPPTwKnQQ5T457Ot/+DrlrniS7CPTa+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33fUopuxdjcJxrb9Vn6ILP68MjssEep9wI8Pb7GDX30=;
 b=KN7RC0fJodovaAOalhj8+kctwMJpniZ4t5KlUu33/FscBWfoFK4RCHI4bFmT2FQmhQhA2PppBqS2xbMHo6mAxAyhi4Zld0OdEFeaYxW3Z7RWB5vjPl61LQQNId7NqkdgC+rHZ/Pu87iS8d8PlwTtwK8XiM8w+V4qr3JIKLCzhIc=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB0469.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 08:28:23 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:28:23 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH] drm/imagination: Reorder some fields in struct
 pvr_device_features
Thread-Topic: [PATCH] drm/imagination: Reorder some fields in struct
 pvr_device_features
Thread-Index: AQHdH1d2NrnE05JcjUGwrM2Eg0g7jbaFvBQA
Date: Thu, 30 Jul 2026 08:28:23 +0000
Message-ID: <fd14c014a9f251b4f7a77177c50a62509d1c9763.camel@imgtec.com>
References: <20260729-b4-pvr-device-features-members-reorder-v1-1-d2e18ed8cd5f@imgtec.com>
In-Reply-To: <20260729-b4-pvr-device-features-members-reorder-v1-1-d2e18ed8cd5f@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB0469:EE_
x-ms-office365-filtering-correlation-id: b6a35afe-148e-430f-1b82-08deee14852f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: QhPQZE0OI2YPZpR6LLu+vOX/F5jKhYQAYRUoQJ3gQ7o4JalJWpzqJJeb/VSObkYXm7vVl3jiQ8TX1/boF0uT9DQYUSpPXeGY1gDOhxig0kpq6pdif0PXWZM/2JXqZh5U52WeDRoPGOyVYQao15HopOMXDLgJNMKPltUybSyFOB3OYpr/3/EbvZvu18X5iD2oIxIWfBNVH76K21hnfg7cCjR6w7D5Er3wvV9uCAMjUkKcR0z4pTdKBsVF48bMeGBwU9a1zMQYoEVz9Se28tWRh/K+776HkrjniVotQcXY/1tl4bfUSTaBQiidoqFtxdn8Iv1k8hzwEDGGuB8gjHSEsBlYJ1RllslOS1Zs1RrZuz4na6nRvnV+FkaBAawCNgVmAqqKHrnOlwny7uXfTulM4io3MZnrkC4Au+etGl2j7Jqvxg/1itAcHylGmFfk58jfmkPbxwu5yBMs6R92Js2QTmOb5EaQmsFhFEvmLwHbkhCwqfYLlt/l4CrDijaJqcYfTwsX0zsw5CyGF08ksmOj4XY25ib9Q/GYXTIiTga55yOGj4Sy5UpM0ChIrfWbYYfQZ8vnmF0zI5GfXEVSxlmY9buNb291EW9BxagVnx25xbnElp2g0ojUVcYlldflaIFx2j1RcoQsLrTZxHwOFWBKk9X3pbIvKppKRMPJGB70QqLyttOaLmoJGZ9s/iblBfFQj3Os7wZrKU4ceaRyxE8wz2ZJd0udDvx46c9ZMdpTMzU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVlWE5GZm1VU000TUlQVGRnRWFQSXBxRG52Y0RsTmZXY3kwUkkrcUpoQXlW?=
 =?utf-8?B?OVlpRDRsL3R3ZFNrdHlGNmNtYzNPMWRLbTYzN1VQYnV1RWFJR1NVN0JuelFE?=
 =?utf-8?B?UCs4U1dnck9Lam9hTUt3YkxmQUhJdmJJWW8vcjR3ZGU5TWY5eWk5VlZsNHlS?=
 =?utf-8?B?ZFRzWXFZdmlHZmFFZnZMM0pSSk9iRG9qeGhKdTg0TWFoOHZyc05rUWNqU2Jv?=
 =?utf-8?B?dndsWllBdFM1WnVZYnRBbDZTcjdhYVVOb1hTY0Z6NWRQMEF1Mkp5Q0xucWdD?=
 =?utf-8?B?bzJ0S1lNMEZuQjI0VWNlSWxVRDVJbllwSDlqSzZyZHVrK0hIKzFvS1ppNjNv?=
 =?utf-8?B?ZzhZTVJ0Ni9nMDNtNHExbDRKKzJyMlh6MzVHUmdTMm9aTnRPLzJSczFvNW5T?=
 =?utf-8?B?QTV4Q21uU05Ub1ZsWXRuQjd6Z2tXV0dheStMWWJDNEFuK3ZuSCtJQ1hON2xq?=
 =?utf-8?B?aDY1bUtYOXZRanp5WkdiN1NQaWJRcFJHSTU4ZXZ0S2dTWHAyU0hXZXZqZGJK?=
 =?utf-8?B?RmVvbEFlbEExMnhSVkQvVU9ubThxK3JFdmRidE1Vd0ZhdzcxOE9PcG5IRUxm?=
 =?utf-8?B?dERZNnFJTnd0bHZKUHNjS0ptQUhtQ1BjMm8xakRCV3o2aTRQbm9SeklOWVFU?=
 =?utf-8?B?aFVBaHZudzFUUEQ4a0ZJT1VaKzFwbjd6dlBHK0lYam9tTGM4NjlnYmFtVnB1?=
 =?utf-8?B?YldvelBIL2tHdllSNUtIcWl0NzZjSG1JRmVkeXlQM2puYkp1dVJMS1Fielpi?=
 =?utf-8?B?UFpVa3dINVMxYzAvR0xrekdaVVU1bjRDd0gySldXbFRFSHk5UGsrWWhnMXRW?=
 =?utf-8?B?aFo1TG1TU3B4bXhncXJDTGVVd2hGQUV4SFBXR0d5eEI3ZFNuQjBYeTFUT3cv?=
 =?utf-8?B?d0FwNzRFNnhTT1hGK3AxT3FETTNDQ2VWbXAwY0JSQVA5Yy9PN0NiYy9IaTNp?=
 =?utf-8?B?YU1ZWWE4UUdHdk4wc0hESjZpMzhiTGgyQ3BBZ3BEVldjbi85QUkwS0VjeFZD?=
 =?utf-8?B?TWRQZFAyVlJCSUhuQmUvckdBdUhEdmlNTWgzZGZyTGtqVmtheHd5Um9wTk1N?=
 =?utf-8?B?dk9Ub0N5cFRkc0FXRGw0T3BKNEhPcnpEdzliclVtUEUxVE5wL3Frc3VSQVBU?=
 =?utf-8?B?OWg1eEoxTUErRzF0U0dUV1ZtdnJ0WEplTjhOSkJ5SFlybHJZc0NQaFpWQlQy?=
 =?utf-8?B?QXB5RXJodzdSRGg1OHRITzV3RmNsa0xOdG9Md3dIRWt2SFNoaHJwVHVRcmVz?=
 =?utf-8?B?bEdFTEQ2M2Z2QS9jOU1zK1lETGZ1RDRQdFI5MmNYZGFuUDBMNjNJVmUyc01z?=
 =?utf-8?B?YitPcFpwcEtwTjhxempjaGtKNDg3VVBlenpBdG9naGhUd3gySjBNRFhxRllK?=
 =?utf-8?B?NHJXZ2xxUHpGajY2SmZHdWdnbVVseXBERjYrcG5BVFlML0RCWkMvSzZoZ0g2?=
 =?utf-8?B?V0hsdlJKUFZIYm82TEtoQzdWUCtEUmtESURDbVdpQ2VkUFYweG1KRlBCU3V0?=
 =?utf-8?B?RTZRb3R5Z0xxdWxBOFdCUGkyTjEwbDBwZjUxbEpkZU5OKy9pUzNxRzNqUTNJ?=
 =?utf-8?B?TkM1akdReFVmVktBSnppR21EcTFCRFZTSmZ5bGt4dStWSnlzUnNLWXNNdm1i?=
 =?utf-8?B?bzRXZVVJT2pJbGhiemJJdFVldmtxTTJIcEErLzAxZUR3eHViT3ZKU0RxWVFa?=
 =?utf-8?B?RjE0NUdXQ1hGVGM4QmhIUzVhaStKZ2JraXEvaGVVYittdm0yRVJpQkJvRmJ1?=
 =?utf-8?B?ekh4eGZlNUN4cmdHcWRuaDluay9jOHJsdm5VUkhPcE5qRVhweHBvdW1LdU9a?=
 =?utf-8?B?RHJhVkFkajYvVFpxY0JTeVBSYXdsZ01hbjUwTklnNndZTlNzYlkzYi9rWmcw?=
 =?utf-8?B?RVorLzJLUjdzWGV1eUpHY3JMNjJWSFhyRS9NdHFkRXJtZnU0amZpay9ra051?=
 =?utf-8?B?Y2tBN3g5ZVp4Y2owWXJUdm5PNlZsMzZSemtBbVh0VVlZZW5Vbng2TC8rTjlB?=
 =?utf-8?B?ME5yRTc2VEZWYUl1T0J5ancxRWtoNk9tcDBPc1luVGY0aCtPdDV1R1JxYWhQ?=
 =?utf-8?B?WCtpY2NNa1d1TnNJQXFEeDlibzBQOWZpQ3lya1pJTkpPd0h6SWFDUGFQV1hs?=
 =?utf-8?B?cmQwcjQvNmJUZjg0VWpwSnRZU1ZMYmxNa1hoUXJPTUVCNDNLKzQvVEJKR281?=
 =?utf-8?B?bFNDODZZRzYxOXZwa0h6ZW1iUzlMMWNCQUphbERIYXMxTmk2MFFOWXl2cXpM?=
 =?utf-8?B?TmRPTzJIV1h6L2k1bHBwcHdMb1VTUlB4VTJJSnBYZ1hKejdTMUViczFRWWFw?=
 =?utf-8?B?T3FBbWpHZE02UnhCS2FKZ0FMa29iSmZhSDZNSE01dVRFN3M4QmJRdVZOUTdm?=
 =?utf-8?Q?PzYjtjyp6gKzzTDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC88D2BE242F445A880876FFC134514@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WW7hM5LDT0BpcVNPXk1ctA9FiEq+nD9H/QAN6gKaRh3xJZfv59lp3ymKJeyi6sCnKI+MdwY3W/Ldd1tMT2I6A1zWvHosIT1Bqog9+k+cElVhM1GIS4SYmpTQbgJ6KEC0AriZqeL74IdCE2vKOQ7oMDxkwwCOL1os+Qu/2eSK0a9T2djVhyG+PC71tRDhKAle4NsIAmeqITHRKV9nMrBE4PSlcyFqxei8Zdg4zy6psIpvbcaSBvCArWS2Eb7TIOjci7wPO1Z5HLop1rELeWN/6JYBvLEQ0MCVQeYq2JsekoqHgoaTmfDj+vnqeIzVMvUmNv4DbvxKcDfCdD9LUkjGug==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a35afe-148e-430f-1b82-08deee14852f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:28:23.4361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9AsJQ+EehFJL6fX56WIeGXMgIt9wyxzml3n4uQIKPHp5xXxv/DJmaL/gBxDbUHiOMF88DrTxO4OGgT9HtWx3EHqz+gT3x8x8j3QnxoHf8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB0469
X-Authority-Analysis: v=2.4 cv=NrjhtcdJ c=1 sm=1 tr=0 ts=6a6b0b2c cx=c_pps
 a=PPlipUdcMEwVqOAD9oUDOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=uuG7tOOYQ_fpW9jMQkQA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2MCBTYWx0ZWRfX5f5gZ1dA/vot
 NN2XHeBMLI503I9jpzLFM0SFGINAeeqNGgaPfxGZQrQ2TKS6Lr1bKLzB30wOL3pBtPH9ElyOUNe
 JzYMPL6NdVYnDgyLJWKrQkyTvhSwDCo7WGBAuVUIombyaQFPnQc/Hbiev8AmX78cpCJ9nWHVJZB
 KHJiq+4rNSqR/EgkwnZ11nE6zwEkk1Ekpfa+JIpdw0oLgu4URjr54zW2mRqrP5ve8ZGLdrNpL1p
 hc7PyaMhbrOKy1qGG/QhNs5HUxFUBMAvjsSwOmMelgHAQtwfWktdiU477lcrQKQG8e+Hw4qYVTY
 T9x2UhlTxkzUgOivVnto8cQd29VVRGUWYNHEI8vnSlX69lHDd+JZOh8Wr2D6UtzEo2o4M48yAar
 bJ/hWkRH47w6gWE/Ta03+a428S+q87d454amy8OZEiXVC5FYe5LBUNShQTHxNnQ7YYaPwbJhklv
 aLr3NU8Mn8m0vQYurlQ==
X-Proofpoint-ORIG-GUID: IIR2KGJhmaAEUnGKYmWDNqc5LsoVOOuE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2MCBTYWx0ZWRfX/Gr6tP9LUhzz
 lZOXcQY4kAJqf3U3zZrr+kVrzYoXEuJiO6hPRimX3yKk6yS3GihDqlvXKq6692rTzQnFkt6puKE
 BcJpNOLlhbCrhUtiy+aUaWy06v+0RZs=
X-Proofpoint-GUID: IIR2KGJhmaAEUnGKYmWDNqc5LsoVOOuE
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

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDE1OjQwICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gUmVvcmRlciB0aGUgZmllbGRzIG9mIHN0cnVjdCBwdnJfZGV2aWNlX2ZlYXR1cmVzIHNvIHRo
ZXkgbWF0Y2ggdGhlIG9yZGVyDQo+IGluIGRldmljZSBpbmZvIGVudW0gZm91bmQgaW4gcHZyX3Jv
Z3VlX2Z3aWZfZGV2X2luZm8uaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBEYWR1
IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxs
ZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2RldmljZV9pbmZvLmggfCA2ICsr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Rldmlj
ZV9pbmZvLmggYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2RldmljZV9pbmZvLmgN
Cj4gaW5kZXggZjYxZmI5ODhiNTUzLi5mNmMyODQ1NTMwZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZGV2aWNlX2luZm8uaA0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2RldmljZV9pbmZvLmgNCj4gQEAgLTIyLDEyICsyMiwx
MiBAQCBzdHJ1Y3QgcHZyX2RldmljZV9mZWF0dXJlcyB7DQo+ICAJYm9vbCBoYXNfY29yZWlkX3Bl
cl9vczsNCj4gIAlib29sIGhhc19keW5hbWljX2R1c3RfcG93ZXI7DQo+ICAJYm9vbCBoYXNfZWNj
X3JhbXM7DQo+IC0JYm9vbCBoYXNfZmJfY2RjX3Y0Ow0KPiAtCWJvb2wgaGFzX2ZiY19tYXhfZGVm
YXVsdF9kZXNjcmlwdG9yczsNCj4gLQlib29sIGhhc19mYmNfbWF4X2xhcmdlX2Rlc2NyaXB0b3Jz
Ow0KPiAgCWJvb2wgaGFzX2ZiY2RjOw0KPiAgCWJvb2wgaGFzX2ZiY2RjX2FsZ29yaXRobTsNCj4g
IAlib29sIGhhc19mYmNkY19hcmNoaXRlY3R1cmU7DQo+ICsJYm9vbCBoYXNfZmJjX21heF9kZWZh
dWx0X2Rlc2NyaXB0b3JzOw0KPiArCWJvb2wgaGFzX2ZiY19tYXhfbGFyZ2VfZGVzY3JpcHRvcnM7
DQo+ICsJYm9vbCBoYXNfZmJfY2RjX3Y0Ow0KPiAgCWJvb2wgaGFzX2dwdV9tdWx0aWNvcmVfc3Vw
cG9ydDsNCj4gIAlib29sIGhhc19ncHVfdmlydHVhbGlzYXRpb247DQo+ICAJYm9vbCBoYXNfZ3Nf
cnRhX3N1cHBvcnQ7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3
YWI5ZjE5MDM4NjBjNGI0MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDcyOS1iNC1wdnItZGV2
aWNlLWZlYXR1cmVzLW1lbWJlcnMtcmVvcmRlci05MzdjNWRiNTEwYTANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCg0K
