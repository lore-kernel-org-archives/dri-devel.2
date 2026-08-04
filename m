Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D423C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BAC10EA47;
	Tue,  4 Aug 2026 13:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ugMD9zbO";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="KkyUNvJf";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86E610EA47
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:57:05 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CVAYf3698435; Tue, 4 Aug 2026 14:56:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=mVwpM+/ZF/famRP9dM/myrxUiNOQqOy6MuIt2iuPxHc=; b=ugM
 D9zbOBBe7qA+TRDedogxUdqXwvEMIj/Y3fh9+0y2V9lZoznET6Pb0gM3Cpe94NmC
 9MagZq2IdTAm/KrFVX0CBsrsbH5tkGa7YygXZ5YUl/istePULDEhmlECce9JNpOn
 hRoQgHt136UaZ8SnkXL66FcyuAAvwibHF1gFYmQCytmG7+9IA2EPYC0dgmwshV4H
 1I3xqXw7rKpWcMZTVEhbKvG3psO3XnKYgI0KxJUiDYCCr4I0kDJLbXRXf6BAJsAe
 Is9VFSR1tUR4kQYNof+ttqTRIa1uhgykKkRcSfv8CduNV4k+BBjnGKc964Z7lf/p
 448sFhF3DYzfyKdIsHA==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021111.outbound.protection.outlook.com [52.101.95.111])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fs8vtts3j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 14:56:58 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izngwnb2Eu0xntfqo6TJUsJocFnqLgZceVej7oXmgP/0F1f9KktNwPz9LxDXRPCl4d7poAZF2Swy59ja8ceY60X0VRzWDL5YsLktKuUqnUbMu6PPV8jhFAG+TapAbQZjLkj1DUN6kAwhTe3tF24E1nE1m9FUJrKwD0YiUVpCJUaK/pJZUEmQ6WNZEHci57pptmWiPFwYlT2Adpd6YvoIwW7wpLXv1YDtE37pfJETzmLtU0wznS7jLuIq+A0IuE+AWR2jVmrNo33sxLxMCcTGE/MmW0AFDKBPsVs6icKdRj4LJvpT4gKY4HdUY15pVhB7Q5oJyEvoNbXdtzd8lVmIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVwpM+/ZF/famRP9dM/myrxUiNOQqOy6MuIt2iuPxHc=;
 b=RjIKVSmvYg1d0uLqQPqFUBBsZquwRH/tycpXjymisHPorRwzB2qQDyPdL93n90Fei0GEQu3SSNk4P1IKpxGXsVwkEfcgXDkE9g9R8+t0y6Lwirtdj0Jy79BvzbH2e7U/W28n/aRFN7A/xICi6RF/BLdGiS5EygewJLt1b0TM+K8ZqxOKEymjrEcWPk2AK1uJ5me59FTD/urunyNva4z406dmw6Ebh/Gd1MDeFOX9CznTqBomzqdOE6ayduuJ0UDKxK74E4sCNTRmCrHxd6bOcNlPgilsBMtNDwFyM0eBxt8893AY4xkBigaxi6aCeh0dv2yAuA4gk6S5X7VDs9meNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVwpM+/ZF/famRP9dM/myrxUiNOQqOy6MuIt2iuPxHc=;
 b=KkyUNvJfGZyAGUTSaCtjH+4O431jYg5iMN/10WT7yfD2yk4bvMz3ggeCprdqPTKTUwMIVd0smt+qN8BHjewUu8u4LCjB+DHw4D1YJEZbSIlwRDCxWvxz5vQwl9XBTVVewthpmLHkUFmlkrqc2l2GKCFR8wnnBZFqI4SbN0NfzSk=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB2237.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 13:56:55 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 13:56:55 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: Robert Mazur <Robert.Mazur@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 2/3] drm/imagination: Update Rogue heap comments
Thread-Topic: [PATCH 2/3] drm/imagination: Update Rogue heap comments
Thread-Index: AQHdIzIH7CVDk4fBmUiWBG0O4oPjJraN69IA
Date: Tue, 4 Aug 2026 13:56:55 +0000
Message-ID: <c8e652bbff40fb4e16b6174ede809aeccad23f79.camel@imgtec.com>
References: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
 <20260803-staging-pvr-docs-fixes-v1-2-0d014c7b2671@imgtec.com>
In-Reply-To: <20260803-staging-pvr-docs-fixes-v1-2-0d014c7b2671@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB2237:EE_
x-ms-office365-filtering-correlation-id: a45cf7fc-a16f-4544-1a61-08def2303e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: h+bUw1t1Suhn8ydQfQ4JLfpiNKf/GxFu3HpopQ3BK3oyY6xSN3iSQ8cAtRKG8hgMFHjUaSTL3adMOeK/VxW+TwQB5McSMkW+bTLsIPfwQr/yb/DUfexCSOaVNZwokaVUeLn2NgxZZ9SONAECclGLIR6ud/aBZcNhWVhV3JnIcm8n290M9SUehSbzb2dIuAy5mL+AYqYjNyab3Wqc/Zmov2kNjmjMgJE6J/X9sEnxiS3yslrZJ0FmxXlRBvfQASJhXYZE/hHqIQQfGV39QXt6lqeYLEppyiXegzhmH2y8vbbxQcFt2WUquvZrOmQcd+964ZnFmJU2iXZ6n5fl2BMwyKkrl8kumcSpTm9JulnPywq9wqH+0sytf25LEJmcHhHDUb3aFkrAAW3Y6f0RmsC6GIDxppCdefJGRGHrcThjO50HqjR2XMjE3eVtiLBpGqjJhXzypv8SxZ/5zBZXXdxQ+KTo5zxkAs/hJAXMSVBdVapi0YJxpyOXANSAnMomvrSjFAqIrn28uf1GllQKCHEc6sXNkvHJkrl0vkTOCDXiE1C5fsZXzS6LRhqhbt/dCR1QGXTOAbSHccY8QFTUQk/1/cTdXesZ7NlEk8V3ifxfRnVcVrlFX9NKq11UfdiPd+G1rJ7z04KaIlfsRMnM5qlVrzWOQ1ShnbKImx077gzhAMtCqr4/8J+jcL+43lje46etmX7EY9fE0f/uYrQf9dUE0qB84geXJRtgT+Jw74TQfMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmFQWnJNTlNkNmZQeDIvcGszaEdVRWVRVG5nRGRWdnZDUzVSOE40SnlMNGNw?=
 =?utf-8?B?eFdWSGlrS3JvSVkxM0E5RGxaandMaE04Nit1R29Ka3ZKR0dCRTlHQkVBWG1N?=
 =?utf-8?B?NkdOVlIwQVVzTmdLQzlIQ1k4SzVtaDIwRUdENFdTSDU5VXErcTBjU0h0UjJN?=
 =?utf-8?B?a1BTT2FkUFFZWFpySElWRVlxV0pNaHRVYzZaZ3JFQjJMUGVaNnJkL1RpTGRO?=
 =?utf-8?B?TjhwWjMwdVQ3dzhSR2FzU09jWDN1T09zb2k4cVlIREREclJKdUtubG5CaG9I?=
 =?utf-8?B?a3cyQW1iL29JSVJPRkROY21Ldi96ckw3T0dmWHA3SDM0Mk1aaWRnbFJJNDI3?=
 =?utf-8?B?NzMyWHFLSzNINWkzWWhITkVaYm9WcUxhWlFiVE9KU0VjblJibHdDSGZkbFFr?=
 =?utf-8?B?WGw4ZlhTb0JINExRanNXYnZmMlJ0L0FRb0JuUjY2clB3L3NFUzV2NkJnMnRF?=
 =?utf-8?B?WHdSVWk4TlVoY2xnRU9RYzBNbmduZ0RqaFFnVmNBdWNFUTBDSXRuamk3RG0x?=
 =?utf-8?B?b0JIdDdpL2NDU0ZnTnNndmg4VSszUXpBTmFGRXNYUE9DZmdVcEpCODZGNThq?=
 =?utf-8?B?OWo4SzdIM2x6NWhqOG1ielM2dWp4WWtxZ1ZuQUxiczhLZk1YcEhveGlJUCtD?=
 =?utf-8?B?YUFmN3JNeTVpc3RTbTVITzlSRWl3SThyYk8zNEN3YUxtODZlMWNUcWdjb0Rt?=
 =?utf-8?B?N3QxNTU5dXZiQSt2L09WNzMxL3kvUWpQaXJ2Ukxva1RhZzRZbUhTS0x2a1NC?=
 =?utf-8?B?VjIwakRrUkduMVZHR29WeWxwVU45UitlVyt2VXorTDdXc2lia0sxbjBtRm11?=
 =?utf-8?B?TW5TZlRzc0FzNVFHTzFiWElqbitIZDl5eVhvZnJlUmRxREhzZUNBNW1jbUt5?=
 =?utf-8?B?OHAzT0s2MExlUFhjUXdPSlEyVmJ3clJRVFBKUW1xZnJQSGlBTGNCTE5wUkxZ?=
 =?utf-8?B?UkZHMUgxaWJEeUhGMWRqN0p3cG1JR0RONGNlR09LNnNEeUJVRWFhT0RUY2dj?=
 =?utf-8?B?Zms1dWZVdDVrSFhIUTU1clZlbGRNcDJWVXBISGJrUThpRkQwc1Joa3ZqQUUz?=
 =?utf-8?B?Rk9kOXRmWTZXck9iTFVxUmlEVDNibDZYWDRIYlNtZ1Y4YWZsbjk5RDlnL25X?=
 =?utf-8?B?bXRmMTAvM1NQc2o0KzRYd3AxR01SM3NOKzBiZzZmOFptOGhsVmdVRCtSQ3ZY?=
 =?utf-8?B?ZVVycHIvdVpacWZRdG1zeENNSzhIK0w4TVZJOXJ5aVNQNlBlcU5RUTJESzQ4?=
 =?utf-8?B?QjgxWnpJRTdYNFdKK1luNzQ4N084Y2w3eUlkYkk4VFdhV21DcVJtMithenV3?=
 =?utf-8?B?dDBvelpyNWY5RC80ajVLRXoyRFk5TTNKenhiMXBzaHI3UCtDbTVMUDArMGZZ?=
 =?utf-8?B?N2JTTXFuM0JBWGlscnJmcHJFV05ZWVljanhDLzBYaXZmbVNKb2xoR2JvV0hx?=
 =?utf-8?B?ejlJRWpGZEJlZWtiVDkwcmM5OXoyanNnbG5kb29lMHJoQzRVWnVIYWRlUDBr?=
 =?utf-8?B?T1RuQkNCRkdKUXM4SjFqRGp2QmFXanZocWl1K2c5TG9VMHZUZHBwMjVhRVFF?=
 =?utf-8?B?UnhWWWdiMFhVaFM0RlpsTG51TENWL0Y4cThEWk5HcnRFc3JQZ0tOSTI2VHUr?=
 =?utf-8?B?cW80MXNnNm05ako0cTJ6dnZ4bE11U3U5UmZDdVJiSXVkeG1nU1B2N0p1SDRh?=
 =?utf-8?B?SFJHTno4ZDRaNkNuRXU3TjV5TGxoaGE0NGR0TWpsaE1KVzFadEJEZWN1RFJE?=
 =?utf-8?B?UUdCQ3dYN2RLcENlZ2pBdS83OVVWaTlwUFNXc3RMaDc3eEk3ZnNnUTU0enpB?=
 =?utf-8?B?N2h1eWdZcmh4K3RMTlMwNFA0N09PdVBwc2o4L2hhaVdBZ1RrcWVMTTRtT0Yz?=
 =?utf-8?B?Y0R1ZGpqa3YyZ2N5VzVoNVY1TEFyQnVjdzZqQ1lEaGN6bE50S1lZdU5IRmg1?=
 =?utf-8?B?SDd2M05UN2l3UVZzdkpvYzUwTm91TElSZ3g0TjRtUDEwQzRpSlR2NHdHYlV1?=
 =?utf-8?B?alZHYjUrc3Z1Y3pJL0hLSzE4NTJyNzNCVFc1UGEzZEg3VEpEQ3FqK3NXcXh3?=
 =?utf-8?B?U2hkMDYxcXFobVVRV21NcXNnZkFoRlNtbGpiK082R1Z3cmhDeWpRY0dTcTJp?=
 =?utf-8?B?enE4YUFVVHhIMHJVU0hzSi9rdXFlcXFWLzBPbitzangwUTBHM3dSUFpwcUhp?=
 =?utf-8?B?WnpXR1E1NzM4ZlppcDJoTzNmendKZ0tIOTB3N2F5eTVJZE1Tcm41T29iaS9G?=
 =?utf-8?B?M0pCQXZCMzhvZzI2VUs1cGhUVkladXNLV0x4NEg4b1NVS1IyMVJwQU5wMUdn?=
 =?utf-8?B?UWJoSEtneXZaYlB0M1dJMFBtT09TM0RzUVVlY2thcHFJaXlkb0RrMGs4TXV2?=
 =?utf-8?Q?8EfYpbOPOdtBG5qU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <097550A42E9928469905C55DA38EC062@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: diSMKGW1lg78QKPteRvSX1gEu7ow/IewHYohsRb83Rn1hw89xniXhHOJO96K9jB9xkq2KKRlNXy5X2X/WXgyBfjHGUYcMCGzFHxGDEgCkr1wks7ooodN00/f606aDJV0pcc6ve60CR6pMu+t+xYjbO1BbHD+u0bqgOrwtQEKJjfRs/FBdFntmnNJl0SXnp9vBt7rbCjYOZ6p11zyL9nP078ruDV2c2KoM5DYpcQj7EzU9+bzTWfKQ3g7R44tvsXQyZX4xewi0v8QaoUgNAlRr3+/7jBv2w3KN+a503e7Odyud8C6waCPBOlvByimBOa2YbAX0iVUjsjBTE3t4rvsQw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a45cf7fc-a16f-4544-1a61-08def2303e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 13:56:55.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjQB5AXjjttArksdSYQyd/AzdqvEJU56Vsu1/BHH5ieX8UAyI1AQ/RpJ/NePACax9Fb53lwVWf3Zk2OMznQui06XmrjDQUlP9N1uXKE83i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB2237
X-Proofpoint-ORIG-GUID: BrXfzv9eiCcZaQ8x68eFzc8NHaZ4q-Th
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMiBTYWx0ZWRfX5QbqSMHMjzVu
 kBn5OrhttRTbUw150of32wSYVYdO+q3g/hmMt70b9a2zeUgYktjsG1zzW8Vctv3W7yvrrqgv7u1
 lFa6qaSccGfLHaozuBLI6LleR3P+hes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMiBTYWx0ZWRfX3Fewt7Awfni3
 fifqfNLP0dLI32SXSMvvwCLbvlSj3eMXaTDfXnF3Zup7z7IRV1CFXSsHao+phy/TiLwURtywhY2
 TaXQvq9h0vNzm2013RgYUkX/M1xa0tfxjxqAtLshal+ajLmFK6IdE/kQP2xPsjTEzWn9hBjlmaX
 zAs0jLctYRVzq19R+XPtJErD11IsuSxoWr6G8R5Nc2f+N7u9Lky3RsiuYMq9p4cTSEwvdoefuBo
 59/JjBoA7p7R4mGDckkjg+WnnUvaoTBWUHsMDaWGq4HhdiLUea2gcXLEZGe9YjJFqsH55/M+yxN
 BhR0PQ2aPtU6mjiI38lHi2HfVMuNtmbwrmKqfwNPY5s8BGCybrwfUDZ/QdoPALkrrEmgG1l9f39
 5zs9+Y6WotJookyR/jC8bYWPqydS284rilz/a/ndMFBCgOEitFHQgDbKgbuVoTFXhPlT0U/QUqx
 GZHGGnKWEz12ORBcUhA==
X-Proofpoint-GUID: BrXfzv9eiCcZaQ8x68eFzc8NHaZ4q-Th
X-Authority-Analysis: v=2.4 cv=D7V37PRj c=1 sm=1 tr=0 ts=6a71efaa cx=c_pps
 a=8zspI6yfgVy7Cbfd8RVNOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=2nUqnbj8j3cbxgi9WCkA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gTW9uLCAyMDI2LTA4LTAzIGF0IDExOjIyICswMTAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBGcm9tOiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4g
DQo+IFVwZGF0ZSBSb2d1ZSBoZWFwIG1lbW9yeSBjb21tZW50cyB0byBmaXggdHlwb3MuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBp
bWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBp
bWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3JvZ3VlX2hlYXBfY29uZmlnLmggfCAxMCArKysrKy0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfaGVhcF9j
b25maWcuaCBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfaGVhcF9jb25m
aWcuaA0KPiBpbmRleCA2ODQ3NjYwMDY3MDMuLjVjMzNiMzQyZGRhNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9oZWFwX2NvbmZpZy5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcm9ndWVfaGVhcF9jb25maWcuaA0K
PiBAQCAtMzMsMTIgKzMzLDEyIEBADQo+ICAvKiAwIE1pQiB0byA0IE1pQiwgc2l6ZSBvZiA0IE1p
QiA6IFJFU0VSVkVEICovDQo+ICANCj4gIC8qIDB4MDBfMDA0MF8wMDAwIC0gMHg3Rl9GRkMwXzAw
MDAgKiovDQo+IC0vKiA0IE1pQiB0byA1MTIgR2lCLCBzaXplIG9mIDUxMiBHaUIgbGVzcyA0IE1p
QiA6IFJFU0VSVkVEICoqLw0KPiArLyogNCBNaUIgdG8gNTEyIEdpQiwgc2l6ZSBvZiA1MTIgR2lC
IGxlc3MgNCBNaUIgOiBSRVNFUlZFRCAqLw0KPiAgDQo+ICAvKiAweDgwXzAwMDBfMDAwMCAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
DQo+ICANCj4gIC8qIDB4ODBfMDAwMF8wMDAwIC0gMHg5Rl9GRkZGX0ZGRkYgKiovDQo+IC0vKiA1
MTIgR2lCIHRvIDY0MCBHaUIsIHNpemUgb2YgMTI4IEdpQiA6IEdFTkVSQUxfSEVBUCAqKi8NCj4g
Ky8qIDUxMiBHaUIgdG8gNjQwIEdpQiwgc2l6ZSBvZiAxMjggR2lCIDogR0VORVJBTF9IRUFQICov
DQo+ICAjZGVmaW5lIFJPR1VFX0dFTkVSQUxfSEVBUF9CQVNFIDB4ODAwMDAwMDAwMHVsbA0KPiAg
I2RlZmluZSBST0dVRV9HRU5FUkFMX0hFQVBfU0laRSBTWl8xMjhHDQo+ICANCj4gQEAgLTYyLDcg
KzYyLDcgQEANCj4gICNkZWZpbmUgUk9HVUVfUERTQ09ERURBVEFfSEVBUF9TSVpFIFNaXzRHDQo+
ICANCj4gIC8qIDB4REJfMDAwMF8wMDAwIC0gMHhEQl9GRkZGX0ZGRkYgKi8NCj4gLS8qIDg3NiBH
aUIgdG8gODgwIEdpQiwgc2l6ZSBvZiAyNTYgTWlCIChyZXNlcnZlZCA0R2lCKSA6IEJSTiAqKi8N
Cj4gKy8qIDg3NiBHaUIgdG8gODgwIEdpQiwgc2l6ZSBvZiAyNTYgTWlCIChyZXNlcnZlZCA0R2lC
KSA6IEJSTiAqLw0KPiAgLyoNCj4gICAqIFRoZSBCUk42MzE0MiBxdWlyayB3b3JrYXJvdW5kIHJl
cXVpcmVzIFJlZ2lvbiBIZWFkZXIgbWVtb3J5IHRvIGJlIGF0IHRoZSB0b3ANCj4gICAqIG9mIGEg
MTZHaUIgYWxpZ25lZCByYW5nZS4gVGhpcyBpcyBzbyB3aGVuIG1hc2tlZCB3aXRoIDB4MDNGRkZG
RkZGRiB0aGUNCj4gQEAgLTgyLDcgKzgyLDcgQEANCj4gIC8qIDB4RTFfMDAwMF8wMDAwIC0gMHhF
MV9CRkZGX0ZGRkYgKi8NCj4gIC8qIDkwMCBHaUIgdG8gOTAzIEdpQiwgc2l6ZSBvZiAzIEdpQiA6
IFJFU0VSVkVEICovDQo+ICANCj4gLS8qIDB4RTFfQzAwMF8wMDAgLSAweEUxX0ZGRkZfRkZGRiAq
Lw0KPiArLyogMHhFMV9DMDAwXzAwMDAgLSAweEUxX0ZGRkZfRkZGRiAqLw0KPiAgLyogOTAzIEdp
QiB0byA5MDQgR2lCLCByZXNlcnZlZCAxIEdpQiwgOiBGSVJNV0FSRV9IRUFQICovDQo+ICAjZGVm
aW5lIFJPR1VFX0ZXX0hFQVBfQkFTRSAweEUxQzAwMDAwMDB1bGwNCj4gIA0KPiBAQCAtOTAsNyAr
OTAsNyBAQA0KPiAgLyogOTA0IEdpQiB0byA5MTIgR2lCLCBzaXplIG9mIDggR2lCIDogRlJFRSAq
Lw0KPiAgDQo+ICAvKiAweEU0XzAwMDBfMDAwMCAtIDB4RTdfRkZGRl9GRkZGICovDQo+IC0vKiA5
MTIgR2lCIHRvIDk2OCBHaUIsIHNpemUgb2YgMTYgR2lCIDogVFJBTlNGRVJfRlJBRyAqLw0KPiAr
LyogOTEyIEdpQiB0byA5MjggR2lCLCBzaXplIG9mIDE2IEdpQiA6IFRSQU5TRkVSX0ZSQUcgKi8N
Cj4gICNkZWZpbmUgUk9HVUVfVFJBTlNGRVJfRlJBR19IRUFQX0JBU0UgMHhFNDAwMDAwMDAwdWxs
DQo+ICAjZGVmaW5lIFJPR1VFX1RSQU5TRkVSX0ZSQUdfSEVBUF9TSVpFIFNaXzE2Rw0KPiAgDQo+
IA0KDQo=
