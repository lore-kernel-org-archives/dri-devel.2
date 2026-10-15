Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AAACC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A973A10EBB2;
	Thu, 15 Oct 2026 09:33:27 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C93C10EBB2;
 Thu, 15 Oct 2026 09:33:16 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6gsJW3644337; Thu, 15 Oct 2026 10:33:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=UMlzljiqcr0Fs7x1EQBtu5ybGBxMK10poHwifmfr68g=; b=e4e
 qLX2CRsITd6f+y8MjXdrCwa2k3AhdtRQ9LlGKfiWnKYzDBLHqjZ0x8gasCmHbvkH
 abtwc38EhQoS/2Tm1l3c+3aXdLLNSgJ5cTPmjweMKFfQos4js8X1kNUkMsFaYCc8
 Y30ro19aQJ+YCYlgH7d2mdVUBMttYs/WptSJLZQscyT7bXS13/Dki3i/JdhZoKWO
 4ncl8c9pSUSRaX8QbLmlJoRsOl4KP5whNRhOjdrma65kwElcO6jUqG4BSNQtiE6E
 xaJDLf3bZnJv1T+GkZkkCc8gN9YBE1IAPcA4Foy2m2w9DEmW8Ub2ztut/RzCagAl
 EPMthOj715u57pJIsAA==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021104.outbound.protection.outlook.com [52.101.95.104])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h7det4cw8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 10:33:07 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwBC1gYczJMw3KDz7bI9+xFW02nuOdY7xUxZ3C8RW6QfSjWLlT4+Dly1EMRuPIsD9rHJlAfjuKYPNFoHaY6D42ovbBX6e5VRLyT3UDLBM/clAHTIUBwMywbUm5dP+fEPObNmKuV08YgspdO+cmKOzLk3I4H+7Ugrhb0PvJhKtzWkJmdmfBD21ufvu4XSCXvunOW9BZ1boorqPoPiIzRTT5a4HJzrSYXMWlwtcOSJ0itHV9g7DsPSXdDxOW/JIyDHkQzzTIVU+lo8phBzQiL6irG7F6ZImQ6mW+DNmpskitpk1KsyZaGSUof3r6UZoeaM9IeEyGR7P6FU+q4eErDWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMlzljiqcr0Fs7x1EQBtu5ybGBxMK10poHwifmfr68g=;
 b=BxeH4/y6ZvZQiPlyFtLIp1GwTSb3uj01cEF1oG3590Utc5rQ5jSCV0kRvYhQt9/kocsNSwBkX6OsIWLgGUKCjNAv/Ki3ibmyJumNWs2/B+r/eRsVz6L8sTWTbQw/xdxnUf8zfk+hvTahMYxKdnfSv4Z+MIYjoDd0WdkL2evG6XUuNlD8/v41P99kKQVJ0hHPOgTqrLq7gPbMHLOe4bhN4xR8XpLp+XhMgOqIiQSIc5IUPy8znJB7rXwt7VPeIGweetUhzfl4SEin7bCvdUA3+rOspYVR4Py7UjOYjP3qAtdFzUbY9SOL/XT956wtCKfUy/9wPgomPCyCm35inVut2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMlzljiqcr0Fs7x1EQBtu5ybGBxMK10poHwifmfr68g=;
 b=n5zT1wdv6/BFcDsABAlkLKlYyjiv5dEWAS6jAFLIG0/5XJea9aLd2TwMBdeeI1ouBGI0Xov2xKEMkAm1aRVi9AmLwwVj5T65DFcre1lNYUXSbxx+a9aME4Wl1dVo2CKWIjRo5y8ENegvRN7fX6CMe6G9w/uAVdwa2kJmvLdUTcg=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWLP265MB6230.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 09:33:01 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 09:33:01 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Topic: [PATCH v2 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Index: AQHdXIgsriTj1xhiUUyXe7rDRM/02g==
Date: Thu, 15 Oct 2026 09:33:01 +0000
Message-ID: <1db683e35d75a4cc05f75e6aef959a3eab516c3d.camel@imgtec.com>
References: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
In-Reply-To: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWLP265MB6230:EE_
x-ms-office365-filtering-correlation-id: 9133a3c1-dfbb-4fe1-5a54-08df2a9f4ead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|1800799024|366016|38070700021|56012099006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: fPchZZxDNzj0PBBS2018UWwigjtL9QddATAyY5j1BdfijCYpLlEHAMEof3wIU0774CK1XQ6hSCOk2gMlzor39mIVm/oncrhmk3Q2/Ejm+QE46JXSygi2y4QekrIsAi6/JDhJnqVemjKIPhUi3JmutBJjL4CB3TAXHF7YqEryAM8rV0jqd7iKxi7Pe+d0eRRZ3THywQHl5NESJLcV3DVOfQcHez6asUHUDbMTJV7w4jnXAw/EACGv9klmBakiG8x1YFBwRcS6mXjBt9baNyqVrtTAs00bDKTZKKgj/po5OZBwkc0AABfxxZIeejwHTHUljS0drOmsVDk+zGtMg1vVe2ChhJ7OdDYuML1s8DPrgipKSqqtZfMeL+OrgezCeViFwM76p+tawFkulXYT40IOT8wM9Z30fVALpBoj9s8QHy3Xh2i47zUFe1mEuLqwP9Xc8d2eL664GjYdFu7TXUNAmRUjswsbx2FFBhxvwIbDxHov3KeAAn1lzIJx8eGnCgBBlnxCeil4LrmDiPOozt4wGzZt+NMBysgPtZww/rcP+nCrsNW7Iebd+ohcVkAo/WfQWUPF5hgHKx5yDPVV/N8dqdEjmOoUE356J/AegFRfT57zwQQFvXA7E7kVpA0CYveks0ZGNUH4yCa0GhWboDBW4XSOiCpd/AEU8cdQeKm+TdQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkpEbUlMOWhsN2hMMkpkMjVPaEdNc204TTRZV2RGTy9JMXJzNVhFSzdOODcr?=
 =?utf-8?B?c1ZDa1I2Ly9pbnZsRHFWeTFESzBubStENDlXS0RNOUl5Vm5qNFBRUzRiOXVE?=
 =?utf-8?B?NTdhRjU4cElOMnhvbzlsTXR3ZGFWV0VQTVQzbFJXM1Y3MGlqaTZtQzVGWTdk?=
 =?utf-8?B?S0dzcjRybHcreEdBRllDaUFkREg1U2lUYTlHQy91Z1JrYWJBUUxjczlLQnVm?=
 =?utf-8?B?NkUrWWJUUmhnaU9zcUFwZGtFTjJMU3FRclU2cGRaL1pOb2liRlJGN2JuTEFi?=
 =?utf-8?B?UFRCWXkxa2Rmb3M2YzkwaFNuVTdaRzBuSE5FQ2NLczdraFFudTBJM043YXlO?=
 =?utf-8?B?cm0wdFA2SjBpeXZkbCtpZWpXUXZhcUd5Q1pyS2dTYjRia0Z0NEJKOWFuYVlR?=
 =?utf-8?B?ZEtBT2Z3MEk0eFg2Vy8vOEhieEVldUhuejczYUNNZmliTTFlcHBkN3VqYTNR?=
 =?utf-8?B?UHQvRzdLdW0rOTZuV3R2MmdSb1VyODV4SXNhZksyRHdhLzk2WXo1M2FtMVJl?=
 =?utf-8?B?aDhOVzYwVUtKUW5PbDdEbGZyRGhlMFoyeVp1eEQrNDBMSmluOFNOOVlTcWwz?=
 =?utf-8?B?T3YrbWIvSDQ3Rm5Rd0pESjV0NndDVmFpWWhKQjdmM1BNMTJiSWJLVHh3dzFY?=
 =?utf-8?B?anFaUFQ1S3hqcEd4OUE4WHdJK0J4Slk4a0k5eFNrZkwzSk1XZkVuTi9JdzVr?=
 =?utf-8?B?S1BRV0hYOXFnZjk4QXJURG5PK3NrVU9VaS9FcGI1bzJKRElPWm1DYWhRUDJ4?=
 =?utf-8?B?NEhhS2xJd3A3cFUzU2tzVE1jSWkrbVJRMkRvODVyNG5jdU5zc3NMYnFEamVV?=
 =?utf-8?B?cXc3ZGtaSjljTExDdVU4L2tINU5oM0sxQVBMaHFHbnBsbW1vQThaUUc0UlBL?=
 =?utf-8?B?VWh2dkFxUDgxWjB1Y3JZdWk3dWhBaTNUS0VLWWs4NE1jSXBhWEhkQVB4YTND?=
 =?utf-8?B?RDhyTW1yZ2lvT0g2UVdJU2FLQzNIdmpLdjZVT0MyRjJWM3NIV3RWN01Pb2xM?=
 =?utf-8?B?R01vWTFOSFFCWWUwTmRtTU92Mm55TnVtUCtQeFM3QzVsR09xQlBTRUsyMStH?=
 =?utf-8?B?ckJHNFN3VW9VWW1RU0VzazcwZEQ0WnArZnd1SWRQVHg4UnpPNlZCU1pNdHkw?=
 =?utf-8?B?TFhsM05rYnEzbkVhQS9tdGF6UVIwOVZTVkladkxKVUlTeXVOSVFJZW1JdnMv?=
 =?utf-8?B?ZjBRcDY5YU1nWTJiMERZL3JpVWluQ2tad0IxOFl3WlNSNCsxWVo0c3VYb3Na?=
 =?utf-8?B?QVBKTUJIdXpYYUMvRHpXYjRnaEdrRWhncWdRdU9qVXdiTEFsdHh1OTJzeUVT?=
 =?utf-8?B?WmRuNjk1TUdOSmJNYlpJK0twRVl0ZWs3bE5KTkZiZXE5dkF4cDlNWGtsOVVw?=
 =?utf-8?B?Q1U4WS9DelE0SCtBM1lEQTBnclIyb2Q2OVFzcUlRMU5JMiswQkFHN1gvWkox?=
 =?utf-8?B?UTFVOFIzbXFidnBjNVNUY0hFTmU0VHh5VVZBRm9wZ2xhd2tmL01qQU03cC9D?=
 =?utf-8?B?cytmbVJ5enFZREFoY0FIV1JkRmI1NklEVnlWWGJnZWJFRlBCQjl0aGZ3cTF2?=
 =?utf-8?B?NTZWVUg3dmRhbWFGTU9hb2RWRjZ0TWlka3NjT2l2MDFtc3NsOE9WYUxNRU5E?=
 =?utf-8?B?QnprOEdCTXJMQzArNEpzVmtkNWtLLytRWmcwSXpaQjRSUWlFM0ZIY1dwTGFo?=
 =?utf-8?B?bUx5alFlL0hneitCVW5BUDkvQTV5eE51dkFWeE9DMmIzWDVZbk56TzB3Rktt?=
 =?utf-8?B?NHAvajVrTjVwQkxZODlWZE1aVm5vcngwek1yMmlaZldkSFBRcG1MYm1FODR0?=
 =?utf-8?B?ZFlLenduQW00dkYzbVJxMHU1ZDJoL0ZSQkYyMXNIVzlhVUFqcnlSTGZ4UTZB?=
 =?utf-8?B?QW4wVk5xL0w1R3JtZkNrSkdpTWt5dlNHb3RwV1ZMNzRBK3JwSlBUejNNNGVT?=
 =?utf-8?B?aGt0WFp6SEI1MzR5YWJMKzc0VUZ4R3VsQ3Jrc0VKUnlJNG43OWdLb1dCYkxv?=
 =?utf-8?B?OG55bElwWnV3cjd1em5MczhxNDN4NzlRK3ozeitOUkRBWTh2REhpR2RCc1Nn?=
 =?utf-8?B?TmJQTnNOVE1ZbDd0bVdhakdVdVl4TnlPQk1ZOGxzNSt3eXRiRmxIUHF3d3RI?=
 =?utf-8?B?RjVUMEduT0JZbGhRVjlkU1Q4QWFRbG1iN1NmZXhsSVQzaVF4bWQyRWVOc25L?=
 =?utf-8?B?S1dVSFJPcWh1Q1E0ZkRhTHBwcUtkblhpZzllTjl3QWtXaklGWDdmNndpbDJu?=
 =?utf-8?B?Z3RUeVZ1TWxLeS9kdjFCUy9mYlZVVU9EeFd6UUZNSWJjWFQyWTZlcVExT1lE?=
 =?utf-8?B?RnhWWFBEOWFNcGxVVDdzSnR5TjZ6VW5GWGZmNitLekpERGVzb1FZdllwclNY?=
 =?utf-8?Q?XeCLrCIyxIoxhnHAD2v4TpwAlrJNVEAQxoAjzI3Xwm88h?=
x-ms-exchange-antispam-messagedata-1: pKbVTUBzRtga7Y+vM+rP1ZY1N85mtMEoZ58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B5B47DB0B70142BA9DF9C65528A3B2@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cbrYfWesk32o24YotLWFqNG57etjSLdLiI1jRWkfriB4+/u4+muok+aK19m1AtVW62YT7UhyS6fku1df5hCNR+vQAvoTL2xUMueiP+gAYJuORGCkZhXSEZ8aMbop2r0sox3zwGUbrmB8+I+8Shaky/c8mVQVtzz8zN1725m8rIukOBUHksVW/nfkkuXX022wkCtMeUDKwfh7iWfmj0kxkC04A8Elw5tEwFFjm7hJLxc/POGARBD5zmTU67IqKrjmI+J5M0LrFR3ZnqHyIJFhnvMFV2ERnlEKXn9rn0jTiHXxmWGZ2e/YuWjT6kqP44EcFMQOe3NgtzP991nJQDsoTQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9133a3c1-dfbb-4fe1-5a54-08df2a9f4ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:33:01.7816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3fRU3INrW3kc2nd1xYlQEejL9vWWK/nUT1Bn/qyuREyamyGmVtk5PVPEQqwAln9lqcjELor7WqDL8szsU6YBd1SWpqBHzH8mx/PveZmxxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6230
X-Proofpoint-ORIG-GUID: Dkw48tpP-ToxM_ATWKsuZMEUR5nTODfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNyBTYWx0ZWRfX0z11252ohd5V
 6S48i2nqgiWV3FD0jzRVxMx2e3z+oZDBxJhrzMGOcR+ZvCXI5JE7pgL+ok5IqoDe35VV9ST6CFw
 nKxDsh0SS3Ae6XItN51MACijp2RiKGFziDK2U/wA6w+m106H0+SOh+IetpYIJwlqQ+Ef6OD9TOq
 1KMLLb6PN194Ea2mlb1c8I3q9tRCyyV+h4zQETt4BMGTOOxha6gY4wDEGXevWTaV2giV2GH5A+p
 t3e2mpasWtqbB2ySuxvA6siRBKYLnafvc7JB6/uHHpm+1grrewHfOi62kM/RuHF/76fw2H5nGYm
 VpdIOT5ruYOYOaMqofiINP8Hrzd8jdPCIPEKZWEyGKpzp8jyP+TPl1DohN9H8yxbLYwdBckD7Vg
 jyO+VBCLIV1fgaCMN5RukO2w1ss+QBIDIjGWPK6SWs2D7IVoKlo0QAkBpFwDcfuZ7YR0j0p8gIF
 io9Zc4S2TzmhyBJX/0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNyBTYWx0ZWRfX1gM9CzRYk/xI
 vlXcvA+1kOuh8oQb1zKc8cTqXXL/x8oD5S4pDSCIPnri0Sb729kMA14zBfYmJ/e5tLZQE7QyT2e
 3votbJPpM1M6xgFFIAazbj6Ab0UwEjU=
X-Authority-Analysis: v=2.4 cv=OO6yTiaB c=1 sm=1 tr=0 ts=6ad09dd3 cx=c_pps
 a=l8MLdaVSjyJ/LglENeVgfg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=vyTcaRNAPyhu-duRsvMA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Dkw48tpP-ToxM_ATWKsuZMEUR5nTODfD
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

T24gTW9uLCAyMDI2LTEwLTEyIGF0IDEzOjIwICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IC0gUmVzdHJpY3QgdGhlIGluY2x1c2lvbiBvZiBNTVUgZGVmaW5lcyB0byBN
TVUgY29kZS4NCj4gLSBSZWZhY3RvciBNTVUgZGVmaW5lcyB0byB1c2Uga2VybmVsIHN0eWxlIGFu
ZCBhY2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1
LmRhZHVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gVXBkYXRlIHRo
ZSBwdnJfcGFnZV90YWJsZV9sMl9lbnRyeV9yYXdfc2V0KCkgZGVzY3JpcHRpb24gdG8gYmV0dGVy
IHJlZmxlY3QgdGhlIGdlbmVyYWwgY2hhbmdlcy4NCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL3Bh
dGNoLm1zZ2lkLmxpbmsvMjAyNjA5MzAtYjQtaW5jbHVkZS1tbXUtZGVmaW5lcy1vbmx5LWluLW1t
dS1jb2RlLXYxLTAtMjkxZWFkZmRlMjNiQGltZ3RlYy5jb20NCj4gDQpGb3IgdGhlIHNlcmllczoN
ClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+DQoN
ClRoYW5rcywNCkJyYWplc2gNCj4gVG86IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1n
dGVjLmNvbT4NCj4gVG86IEx1aWdpIFNhbnRpdmV0dGkgPGx1aWdpLnNhbnRpdmV0dGlAaW1ndGVj
LmNvbT4NCj4gVG86IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5p
bnRlbC5jb20+DQo+IFRvOiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+DQo+IFRv
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gVG86IERhdmlkIEFp
cmxpZSA8YWlybGllZEBnbWFpbC5jb20+DQo+IFRvOiBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3
bGwuY2g+DQo+IENjOiBpbWFnaW5hdGlvbkBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gDQo+IC0tLQ0KPiBBbGVzc2lvIEJlbGxlICgyKToNCj4gICAgICAgZHJtL2lt
YWdpbmF0aW9uOiBTd2l0Y2ggdG8ga2VybmVsLXN0eWxlIE1NVSBkZWZpbmVzIGFuZCBhY2Nlc3MN
Cj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBEb24ndCBpbmNsdWRlIE1NVSBkZWZpbmVzIG91dHNp
ZGUgb2YgTU1VIGNvZGUNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21t
dS5jICAgICAgICAgICAgfCAgOTEgKysrKy0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX3JvZ3VlX21tdV9kZWZzLmggfCAyMzkgKysrKysrKysrKystLS0tLS0tLS0tLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uaCAgICAgICAgICAgICB8ICAg
MiAtDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspLCAxODEgZGVsZXRpb25z
KC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNmUzNzVkZTk5ZDBjNDIwMTY5NDgxZmNkMzYwNjQx
NzdhYjU1YjA5ZA0KPiBjaGFuZ2UtaWQ6IDIwMjYwOTMwLWI0LWluY2x1ZGUtbW11LWRlZmluZXMt
b25seS1pbi1tbXUtY29kZS1hMTM5ODgwZjdmY2UNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0g
IA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4gDQoNCg==
