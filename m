Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0611C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB8210EBB6;
	Fri, 11 Sep 2026 10:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Kzkgb5Td";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="MJf3xzbm";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A8310EBB6;
 Fri, 11 Sep 2026 10:33:02 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7nild1456396; Fri, 11 Sep 2026 11:32:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=hgOhbFKk9QR/KeJkiBbxOGEjWsrX3vxgV0F9rjwn1mI=; b=Kzk
 gb5TdtCb8en609Rmyye/xGPXuK0uwLhW1ZsunR7hiFxRJ4BrCe1iTCnn6Xp2U5ui
 ur7QeH6G4UZFVR+ztjyT4Vnzhn1LkCI/fRgm/TkbIEPOaD5/52OhQJ7mvoEWWVdc
 ttTzEDUqObe79D5tSOdJUm7+sX3wmHlpQTQkvMGXBCCkWcrkMfCTwAtYBeAm//B4
 XE+cVtsBp3hZzHyz4eXRIExbb9E/50MR+CV/p0rW/V51BaDVua1Uw2G4cTFR6VM4
 JDQYczZe7K/nLfDFSeZre9JC0Te2Rs6m9DlzjhevUVhDTJcJkmLvV7WL7GN0TMSk
 qyKrHN6jFrmuxfKPcTw==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gkk89s3c5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 11:32:47 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htcRqA5fl+aOhvvIIk332OJyRkdulQlS63M7zczknhnTRVpCC/qPEEkIo8pM1pw5qPGFa1C0wQIrx3gTAnxtRzoRmT6V0T5R31cklC/MZcVihK4A14pJGOoHTbUxvPGIWSV5h00M6DH0uFDdVRuvYTUR7C/rlDcwaX8bAs61tcp8VVuFaXATdA6BXTQLGsmO1I879yIG+tQkMD4YN5+C6s6/gyjTrz7k/MD8MzclXjKB7X3gIvR5R3Lq0cU46TNlICPDnqqdb1YNJsGAYJaMEwjyY5RumvfkDtkJdh6GD5l0Ot7TzRv5XTDtWfNCdeIsDeXCOhH+Tn8yM7PcBdgirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgOhbFKk9QR/KeJkiBbxOGEjWsrX3vxgV0F9rjwn1mI=;
 b=q1NgmCdRRlKF0CEIBMNc2I/GC9fkyeuq/BHmHpw3w++kU0vqbo1bQGU3GDj3Uh+rQSZH4PUItBmLF5sk9NDzuy9SApg5vHWC+o2aHz0pkE11obwhJaUaq5xbWuPqYSFxVsctbThSa75LhDkn+7icZcu4/ZakRpLb4Vfz/6EwuAjQFgovQ5l//++yoerajJ32DZzY9Z0rKtFU6EBAE7h07+tGNY8WLBeVWuljsEen+8UfHXShtQBSCWqOcMk6uYi+MT9R8/Zhd3pPmLpnWxNNZNpAzFhQytjm95OaJ7s6oGUoQnGLGVjiy8DLCxoWcrk2jWPKikbo6FDHqGEsVQGE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgOhbFKk9QR/KeJkiBbxOGEjWsrX3vxgV0F9rjwn1mI=;
 b=MJf3xzbmnbWRBsVF9Fi+I9nfxKgBp3OmDOP9VmxcM4TjHSAfMjUzplY1MoDBt1m1DPtn1c/RKP7XFeE7d8v9CrMuPPvV2at2WTD0z/nIK4+lV3jq3lG/zyHfPuwE+zxQoZQXOnQ0v2iar4E/9c0vG9eANP9j6Yn1NVxkX5T67CQ=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO0P265MB3034.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:32:44 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:32:44 +0000
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
Subject: Re: [PATCH/RFC 3/3] arm64: dts: renesas: r8a779h0: Add GPU node
Thread-Topic: [PATCH/RFC 3/3] arm64: dts: renesas: r8a779h0: Add GPU node
Thread-Index: AQHdQP0e+t3otZXMUUaWu4FaeunH6LbJL8eA
Date: Fri, 11 Sep 2026 10:32:44 +0000
Message-ID: <01f4558dd80451880a9bb72766fc283ade4e295d.camel@imgtec.com>
References: <cover.1789028076.git.geert+renesas@glider.be>
 <2eb9d054023049e1aa282c141981a39de4d4abe6.1789028076.git.geert+renesas@glider.be>
In-Reply-To: <2eb9d054023049e1aa282c141981a39de4d4abe6.1789028076.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO0P265MB3034:EE_
x-ms-office365-filtering-correlation-id: ed74bd2b-0769-4f2b-5640-08df0ff003f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: 2OrBYN2smMfQTMqVWIKRN6u47l2IpGnklSQEayt81eiv7yd9v0LSh/6lEuShX8lRU3GXlR291Z4f4ZxijSHUVR5KZ0jk17V+IrDnXiROVXNo9wWAjAlWyp4BdopB+p0xiw9pYn+WKfzsJTTr8hsg7kAXJ4PLhTQhzpXO7iV+Huq7BCJG6bxTbIv9v5IOFAgYxHboQde18gvh4ylFTmGn/+KOpTQOqUGsQAioP3SlYGjtAwLETjHf0QS/eXgPLsYZIxDsk9bu9QgFRFRtkq6ITGmcnFfE12s3UAY1wxU5yDaxvApOyXpJioRwDvjXwRSZxBcvN3Cgax0NvHxpzoiWmDBbtY60bhAYVkm2BctqStBiC2d6WFf7i6mh++nqbt5XYIlZcRnp2+FhxGU+KicmmW49OcxbUQBvKs5odGcYUlfZmH1pdGwGUJ65i7LFVcVNt2WdqQ2/V7YxYBf18jkELkc0j8rI+Mp6W6sGmTbwTvV3PBLmUlxBhDJBOikp3nVESO9KLk2OFhwtsHNv01av1mksuYE3m/LeuuHkowT+KAorN2DmmekYJCDGO8wBVA24kfmWsZePLqQ33hC24Rg8RRmagCrMDmLt08IRSlkdvycDKWHEKKi6NLLHadAB1XhDEkLaPI5rbnaOTpWv/+Zk9l0AQJU5Cll72tatIBFoqTGOe6HKPsqxtoDhwGUi5ikV1eXseQnvkkHvoN3iMsCXRiMo2iEgFhbx0ZuYH6fd2+A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRKNjRaeC9JZDhlc05HUE1EUGk5YjFSbW4ycGVweHJKOXZXT2RuazMxR1Y3?=
 =?utf-8?B?Qi82WTJYai9PUDFFSnVPVTdxZzdSSTNadHczT29lQ3FJc1pmSGxFOGovSjhl?=
 =?utf-8?B?bmZ0ejJMdU9Zc1RudDQ4Z0xsZmlzUHZJN2MwR1VWU3g0dDE4Tk1wNGgzTVlz?=
 =?utf-8?B?NllIR1JaNHluRVhCcFRwQkFRcFI0b3JiVGJidDNMdmsvRUxSYk4zQVc1Mm5q?=
 =?utf-8?B?NElYcTkvNWp2MWtualp1cUgwY1QwdGFlVExjQ0paaTVCczlCUTZONEtLVjAv?=
 =?utf-8?B?ZG1UU0JkZHJWR1U4VEtmZHY3TENNOWhjM2hBVXphV3pqaDlka1ErZjNxNEkz?=
 =?utf-8?B?dmoxcWZCZHB6NVlSeFFSOVhtTFBFLzVQN0hEYjVUTFpmTlgxQlUyT1JCY2N5?=
 =?utf-8?B?dDcvL0RpdS92U2dhaThYMm9wRjBNaFZUbGFOYnQrNG5XN1ptQlpNTGlTQk1F?=
 =?utf-8?B?bDZDOGZlV0h5RmtlSWtDQmFPZVk1M09SKy8zZ09WTFJQR2VSa2ZneTRYM2Ft?=
 =?utf-8?B?aHlYbkpSRG9sajlkeGh4TEtGa0dYVzFVbjlIV2FmMVFtVHZJN2x3Z1FZTG1x?=
 =?utf-8?B?MUhIYUVIN0FZNVgrc3pJelJvQ3QrTUdCdzNzZFIwVURUYjlLc0wxTXVtNG14?=
 =?utf-8?B?dXhvclBMR1ZtTzhhbTB4ckxKNWk2cGhta2svZHFtVERBQWFBNkg4emN6TXFw?=
 =?utf-8?B?TUt6YklMUC9UZWttVVN3d25XMm9TT0plcjl2R1lnRXlxTlpGTkQvUlRRdUJq?=
 =?utf-8?B?S0pQc05KUjZBaU5kdVVWWFB5aWc5Vks1dVY5MVZKWnhXdnpPcVNwQlkyV3I1?=
 =?utf-8?B?VUtSUWhvVksxSGRoSTJKa2hETnBxUWxoWEt1NE5SVWVpT05HVHRxYThHak5l?=
 =?utf-8?B?UWFUWUxteTd1R1c0OEZVQW5FeWVZcXkvQ1BrbXdaTUxYR0tpcXNLMlpFbUl6?=
 =?utf-8?B?Nnl3dnZBYWwvYkR1WTYzWFdHY2FpMUZoU1ZkbjNrL0F1ZEh1YWxScTI5YlJH?=
 =?utf-8?B?cjhQdXJSeE5MSmN6S1dRTUp1QU9semdTRjlsUmVOWTlOMGd6dzB6YXkrN044?=
 =?utf-8?B?VWVQZVZQdGxCTDI4N0VlVkRFUlJHWVZxM3IwV3lQWmZHZ2xqSTZkcWZwNUZn?=
 =?utf-8?B?R1g2ZzYvMTNETElVaXB4ejZGbldNMEFLQ0hwdjNWOHd0V2FtUmxxLzVsOEg5?=
 =?utf-8?B?bjRhT3BQMUNlN21uS3VNTDgrbjhOejZycTJlazVrdjZ6MzZwQ2ZZOVZjZ2R6?=
 =?utf-8?B?Y1pjZFNxMmkwRkZYZ0FVRGZmMnFVdmtmTkhlOFNGMDVPeDhJWVdZblh3ZDEz?=
 =?utf-8?B?ZTQ1SjUzaUd4elV4TkloK2cvR3E2dFFzOXZseWo2Wm9HcVVWL2VSa2tJY2E2?=
 =?utf-8?B?UG85dnhkVDBVWTIvaVhNaUlQeHpOb2JjamJSZ0NDaEVjckJ1N296alhSQVVa?=
 =?utf-8?B?OHFwRHF4V2xaYVRCbzdpZzk2SHVieWhlcHgwVVlNZXpUOGUzYjUzc0hubW5j?=
 =?utf-8?B?ak1Nam5YYW1RL3RCVGxiMFhzZmo0ZklkK1NHM0lheDNhbVpvV1ozSDdrbjlL?=
 =?utf-8?B?UVJJVDZHMEdINHJKYkRoTDlLajJ4cGViUy9pS1RqbUtNdjc3MXptV3VvNHhR?=
 =?utf-8?B?MDFlcWhDcENNamdwenJkTXdmUUI2d2RubGgvdGk3MVhmeHZKU1BUdWt1OGEx?=
 =?utf-8?B?ZmYra2VoVERVZFRHdE8zWlBkc2tBRE9vWUNobXpQRzlNRUFTNzlDV0gzb3hF?=
 =?utf-8?B?Q1UzZDlTcFo5eWxQR3VOSnVTVTlzNVpSVXFJZ3FDbStPM2VGYzJIaHZLUmpK?=
 =?utf-8?B?QkVBdkpaYy8xRTE4OEcvZkVpZ2c3UU04aWNlUDlXeVlMbFdiY3djNHpPWStu?=
 =?utf-8?B?QW5YS3RQNzhzdWRXSjNmekhsME9MT01WN2hvejV2MUF0WHJCMEQ3RTZrMW1V?=
 =?utf-8?B?RXBzK1JDOG92Y1BhWnphVTd6VVBrYUllcFpiblNOWnpQekFHbGJpNVZUMWJv?=
 =?utf-8?B?KzN5QnVreG1GODVyUUI3a05vQ3krbVVhTmZSamVLRjZub3lxaUJOWGk5blZL?=
 =?utf-8?B?S2RPT2tvWjB5dUE2UHMwSVdwUFkwY2NWcVp1MjhNWGhPMFhRcVFZTjdLd2Fr?=
 =?utf-8?B?ekhyV3EvOFJLZFJoS2o4QnlwSmlycEw4aHI0M2lxdkxRRi9iazl3b01yeWxh?=
 =?utf-8?B?Nk4weHQ3VnM2cm1zZzQ2a1dIV2xka1ovYllMN1E0d25vaVZ0aWg4MDhjbzZx?=
 =?utf-8?B?NmlDNlB4Wm5wa3NkaE1KKzhJVTRrNG1TeW1RckNZMWFIM0NqbkZIcldCeGwv?=
 =?utf-8?B?WkVwRVNzQ1N6T3dBOXdkK2p0dlZ4OVg0bkkxajA0WGwyL2UyRFNHa0taSUlE?=
 =?utf-8?Q?yCob4+uON0kcmEVc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <700ED9F08FB3D740B53CDD700DB2E8D7@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i9FVtm1VXpN4kkJ8VT4wtlr7+DAmTudth37UHb4fRv91o/rPlw1B9koWcW5EcCQhTqfOC5LA9buo119oHu0Ynnxou8tQ6jEFNNf0dxI+UXpVfVmXr4NsXfTV0Ugl2NBmSMfGF/NFcR4ncq5N9HCa1qY/RxXgWfN8PY0MQZGOBI4FcsKSRlLhzRwBe+yp3SQPMkRwksXZBl3AHjmCeFw+BXlGCHUO/5NsdN9KI1ramQAIIQVQNDr0DyMHKCwC8ZiveQyVCS2Eo9xwMEx1Oy7bNGY67bXsrkcJ7/IpSy7fo7X7lcm8QqIaLHzxrIMcPNq3Q5jNNs6BY8MTlYAI7OI/Fw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed74bd2b-0769-4f2b-5640-08df0ff003f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 10:32:44.2370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9STVymcIXC+B0kf9mou3SZQtoc5MZTHdgzYRzzIjM8vp6WMwuJgrafXvCjFzdqjGHNbCTpIW0emAxwJvWr2w7f2o1WycIjB+yeRDXAKHtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3034
X-Proofpoint-GUID: 3kN9zwzsjWCOfujRUE26U1DETsOuCNQK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX1GblGwPCmHHd
 2OJvdgLNbe2BR0WcqUNl7hfnJS/OWaT9awDNFCAY/jBDin+PCNdpGLUMlKFFqfE4N4VXsYb9yyI
 HSs36UC37dDf+o5ok2EAz312/8qkZ3w=
X-Proofpoint-ORIG-GUID: 3kN9zwzsjWCOfujRUE26U1DETsOuCNQK
X-Authority-Analysis: v=2.4 cv=XJyl2ghE c=1 sm=1 tr=0 ts=6aa3d8cf cx=c_pps
 a=ysrxO6CCllPSUQxmLmaEjQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=QkbX9SO17rmWIQ8U__sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX8hGj7gEjONNI
 FfA2qPYqkEftnAN9qht8Kvn8v/VI0c/cAYVDlAlUEVgS5Z2WNw82ydBECsGqtBkNE3TCUw1OW3w
 Vr9Cs7DPn28JcBSCI+qt8adkXkwqrWYVrMAhKyxY9BD5lMS6b8/igiRVGFdJq89D0a/5tMMl/JN
 cBr6MnAonPvhOX0BfCHARTqHfQ5e3FvR9ML/F8F3JNyCNCRS44n7t8BQX3F2aR4eQEdEMwsUQs4
 JWW6q/T3ews4iv8zWlopa93SrucIJNunv0Moqnkb2SuJysnK61APWqyfEW8GPhBeRCuoQrNMzrK
 151sYnCn7JJglRsh4Jc1ofNpZpdFQSTUYC30mXOKMzM9hqmuZA1ZrN3FDtERoaIVAf27AVEUS1P
 HMowLP5Lnr/WrDVT3Jt8PlLSVnrntmHzyjDs843dPg5nQhBLTI65r4RCpe1IEJ3R5GC8YszWGm2
 /eoNhA+FCxps4VbNYHw==
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
dGVyaG9ldmVuIHdyb3RlOg0KPiBBZGQgYSBkZXZpY2Ugbm9kZSBmb3IgdGhlIEltYWdpbmF0aW9u
IFRlY2hub2xvZ2llcyBJTUcgQlhTLTQtNjQgR1BVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gLS0tDQo+IFRJIEsz
IEo3MjFzMiB1c2VzIHRoZSBzYW1lIEdQVSwgYW5kIGZpcm13YXJlIGlzIGF2YWlsYWJsZSBpbiB1
cHN0cmVhbQ0KPiBsaW51eC1maXJtd2FyZS4gIFRoZSBmaXJtd2FyZSBpcyBsb2FkZWQsIGJ1dCBm
YWlscyB0byBib290Og0KPiANCj4gICAgIHBvd2VydnIgZmQwMDAwMDAuZ3B1OiBbZHJtXSBsb2Fk
ZWQgZmlybXdhcmUgcG93ZXJ2ci9yb2d1ZV8zNi41My4xMDQuNzk2X3YxLmZ3DQo+ICAgICBwb3dl
cnZyIGZkMDAwMDAwLmdwdTogW2RybV0gRlcgdmVyc2lvbiB2MS4xIChidWlsZCA2OTc2NzAyIE9T
KQ0KPiAgICAgcG93ZXJ2ciBmZDAwMDAwMC5ncHU6IFtkcm1dICpFUlJPUiogRmlybXdhcmUgZmFp
bGVkIHRvIGJvb3QNCg0KVGhpcyBpcyBzdXNwaWNpb3VzIGJlY2F1c2UgYXMgeW91IHNhaWQgdGhl
IHNhbWUgR1BVL2Zpcm13YXJlIGFyZSBhbHJlYWR5IHVzZWQgb24NCmF0IGxlYXN0IGFub3RoZXIg
cGxhdGZvcm0uIFdlIGhhdmUgYSBWNE0gc28gd2UgY2FuIHRyeSBmaWd1cmluZyBvdXQgc29vbiB3
aGF0J3MNCnByZXZlbnRpbmcgdGhlIGZpcm13YXJlIGZyb20gYm9vdGluZyBmcm9tIHRoZSBkcml2
ZXIvZmlybXdhcmUgcG9pbnQgb2Ygdmlldy4NCg0KSW4gdGhlIG1lYW50aW1lLCBjb3VsZCB5b3Ug
aG9sZCBvZmYgb24gbWVyZ2luZyB0aGUgdXBkYXRlZCBiaW5kaW5ncyBhbmQgRFQgbm9kZQ0KaW4g
Y2FzZSB0aGV5IG5lZWQgZml4aW5nPw0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc5aDAuZHRzaSB8IDIxICsrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc5aDAuZHRzaSBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3NzloMC5kdHNpDQo+IGluZGV4IDBjOWNhMGY5
MGJhZGMwOTYuLmFjNjY2NTU2OGJkODNhMTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcmVuZXNhcy9yOGE3NzloMC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
cmVuZXNhcy9yOGE3NzloMC5kdHNpDQo+IEBAIC0xODczLDYgKzE4NzMsMjcgQEAgaXRzOiBtc2kt
Y29udHJvbGxlckA0MDAwMCB7DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiAgDQo+ICsJCWdzeDogZ3B1
QGZkMDAwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxyOGE3NzloMC1ncHUiLA0K
PiArCQkJCSAgICAgImltZyxpbWctYnhzLTQtNjQiLCAiaW1nLGltZy1yb2d1ZSI7DQo+ICsJCQly
ZWcgPSA8MCAweGZkMDAwMDAwIDAgMHg4MDAwMDA+Ow0KPiArCQkJaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDQ2NCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDxHSUNfU1BJIDQ2NSBJ
UlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDxHSUNfU1BJIDQ2NiBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDxHSUNfU1BJIDQ2NyBJUlFfVFlQRV9MRVZFTF9ISUdI
PiwNCj4gKwkJCQkgICAgIDxHSUNfU1BJIDQ2OCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJ
CQkgICAgIDxHSUNfU1BJIDQ2OSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDxH
SUNfU1BJIDQ3MCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKwkJCQkgICAgIDxHSUNfU1BJIDQ3
MSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKwkJCWNsb2NrcyA9IDwmY3BnIENQR19NT0QgMD47
DQo+ICsJCQljbG9jay1uYW1lcyA9ICJjb3JlIjsNCj4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnN5
c2MgUjhBNzc5SDBfUERfQTMzREdBPiwNCj4gKwkJCQkJPCZzeXNjIFI4QTc3OUgwX1BEX0EyM0RH
Qj47DQo+ICsJCQlwb3dlci1kb21haW4tbmFtZXMgPSAiYSIsICJiIjsNCj4gKwkJCXJlc2V0cyA9
IDwmY3BnIDA+Ow0KPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJfTsNCj4gKw0KPiAg
CQljc2k0MDogY3NpMkBmZTUwMDAwMCB7DQo+ICAJCQljb21wYXRpYmxlID0gInJlbmVzYXMscjhh
Nzc5aDAtY3NpMiI7DQo+ICAJCQlyZWcgPSA8MCAweGZlNTAwMDAwIDAgMHg0MDAwMD47DQoNCg==
