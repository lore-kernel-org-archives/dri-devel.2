Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFEEC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229A210E0E8;
	Wed, 19 Aug 2026 08:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="qcLcBVVp";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="A4t7JqEp";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C85310E0E8;
 Wed, 19 Aug 2026 08:53:16 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J7McHF4005281; Wed, 19 Aug 2026 09:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=VGaw2oV+BIfKHKQFNLAuFfsqv2OtO51hyRZcIUwvAWs=; b=qcL
 cBVVpSIDypdDXC5bGDrAON/AFZMS9rYBtyKC0ODQaYg7Eua8ScMLwCYNxzOoivgV
 Fi2auduVOpOvEk4UJu/jxXmo8r9kgHIbtdHE+QlcQKQAd8lRY6dn7gAa2cAsDa8A
 3c8pmXNsuUq1sxjEoYucXsmtI/WaKs01+CO6b0AOGEM/8oGfliGzFCrZlN3ILdKl
 BFMusqG9W8s3CVyxND1tHqOUrRJ9mFaDaALVDHMaEucVsZubyBtDu3VUbZhYz9ep
 uf3hqhHBEdZHS+iWXANFa4bDy6ZCHGKS8g/BeAH9JDi+OUibJtJp5n2OyQIQrVpO
 s5P4qyej3Obi6+Jqd3A==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021141.outbound.protection.outlook.com [52.101.100.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4g2g6uuu93-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 09:53:01 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3ZBori3HeoQwIFJPVvzTqUp6TnInRbVal+iuEGaabJJctee62y4QIHf1DFRQjoy01wKS+Lv3j9I0kuVFTXQGYybMVNvtgR1N+Jbfh7zV8ZEsCBrxPXNCHjqfMVOEYfQiZWov2PZP8yc9IPBwyM9aGZ0/Hi6Tz9B0L/WdrsHL92hQu1ArrXWfLxIWIAVZ+IvKKtvYTCvMrOLb0QOWW2bTNs3ZNDy8PYGeXb8KkoXXuUWMLxi2TuiG/kaP4+Id/jXIkFQ3Wuc3qUqCTAE/XOUbEHyMuhZkv3eVaM7hvhGYZFME03UB6lZ5X8wmYyd6HhkMTcsWNU2sM5qVZUda/VmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGaw2oV+BIfKHKQFNLAuFfsqv2OtO51hyRZcIUwvAWs=;
 b=OWTFydggqxCivD2p9y/aRqKOkCDU8bCKmYsVCzJAW4QP1ViZpypki6sCYvzxPzUb6loBB01/lgneCJEn2DD/4lv5XgebrUjg2GKm7gb93TkHBsNifopTM9YJ2LBwKRX+KZtSb61C0oKK7rBpFAsN/YGvg2/56q/hrCoRpuX8U7FB/quUJSx1GtlQ47fMJdxw3GHPIW1bU+tDhXq6KvfxxVzuuPv5+dk5KAm4ZpEImBjf0iVYve46ZWRLFLUm0oUe6zmaMR+Tx5mfftK6d1hASbMF24WxWtLZnp8jIjlZiBwfV7+AJARUiZ4wVIfqMoqbBOTYplrN6l6poAEgEjrbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGaw2oV+BIfKHKQFNLAuFfsqv2OtO51hyRZcIUwvAWs=;
 b=A4t7JqEpDDh6PFPIZPJa+ZZyCVkuYEgzGWPIwQqFJLh3MQfqjBV/vQnq1HO5pwfBxJG4lnL/Q6+uHAYqWPG55r0uCHrDCOJdidapMO55HXhSaZZrZeXms8mltUy9qVr4JzAyjCMsla02w4ebyl9ikMxNRTtNIen6fzC0SNa74YY=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWXP265MB3589.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:52:59 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 08:52:58 +0000
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
Subject: Re: [PATCH] drm/imagination: Fix NULL pointer dereference
Thread-Topic: [PATCH] drm/imagination: Fix NULL pointer dereference
Thread-Index: AQHdL7ghBTUpwRQ2/kibto/I3EcZnw==
Date: Wed, 19 Aug 2026 08:52:58 +0000
Message-ID: <26ee842b3b22ddbd43080cb28058403f6c1a168f.camel@imgtec.com>
References: <20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com>
In-Reply-To: <20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWXP265MB3589:EE_
x-ms-office365-filtering-correlation-id: c10498db-a71a-4d33-e116-08defdcf44c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: +oCYZwA/oOXp18lWn2GRo500znLw37le1wDFL0IwxnUfI9bxhlTF6XpHJi9FHgtL62MyrwHIVfU21yjUX7Jt03Yy1B+xEUYMGZk5PMfNbxEBRrn1wSSyaoOsF0NzJ7AY4v0qNqnS3RzF/OdvTCFeriIuJdODFfypon/QP4aixZXiZS3qjfVeAnW5eVAR8JBIPswyguTX0qfEdEHuZr9ZnL2qV3jUndpmZ+jUNCt+aLJz1vJ23bcALA/XULcNPECunx3YYUuW6YnzlapY3QiizdgJGTAGlR9vIYWybbLuWOV2wAFWwX3rFcpApa6Aq3rIpiOvdBvqhWOyZXvqpBf/LReoQf78l+fFxcaf9Z+I1jGpYkmGa4L22mplQkWKFUGeIxqkeg1ipFR2WZtIFE2KSFkZgtd0aNRZLz8NWtLFK23rQ0tJHq1UMZ0is9F27+x/9kH4lp1aMkxGgP2ElXJSqUWiZaTsclWAEF/3elcQl6RcleQwW8RrPAt6i/HQ4CCEDlLCO9cKyDPHo7ZlditnTPtwG7h2L9ueCxDGN7LHcQT/QWRpm0JaQjBrFNaPKO/8v/Nj2n8DYqPhO4ZUtKGoF10F7md5QHQs01qo9QyZoTgc11z5PUtNOOkmYzyQkx4jQC8WPMYmUu/4bFtYLskyn/6iNu7xCIDZDg4A254tB4w3pBzCDqtZo0dBDM6bwvC6EaZdj2RK21t3L6gGHefZ6sAJveyCvZ9YpuIicoZI0xc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlRhS2ZkMTJJd1p1NEpTeExmTXRjZE5jV29RemRHbjVJNDFJdnJkbzIyZVZq?=
 =?utf-8?B?MTU0MHVwWUczdk55NWY2MS8zNWt1OEdnaGdzbWRCNGtKNW9mR1ZjTWxPYlha?=
 =?utf-8?B?Z0p2NGI5V3NQTEVRUC9ad2cvd2lMc2NJR3dzc3FsY2tEU2J2ZndNN0NJNTY0?=
 =?utf-8?B?OHZGSUdmd3lKWjZKaVJOUVNWZDZCMGhuNXJMSjdoN3RkNGxJY3kza09xOCth?=
 =?utf-8?B?RmJnYUVnam54N1p5bDJXVjRGRHo1Qi9QLzVCVkNBc0cvRVFPYW5GdkRZSXRZ?=
 =?utf-8?B?LytVc1RGRCtFZnRESGVRMnZQRVNSazZBWXFMT1hpS0tYQmpLS2JRclMxa2Nn?=
 =?utf-8?B?RG5aRWlFS1F5ZUlQU0JZY3I5MlRaU01XbnJzR0x6SDkzalZpNXFQV3JEZlNl?=
 =?utf-8?B?RkgvSWN0Q1RxK3kzazFlYkZ1bm43eVZvejRjY2sxRkhDODBwOUZ0cWRzZ2FW?=
 =?utf-8?B?bDNxWUMyUkkwOGlMUVptSXROV3g5bXVFNnY5Syt0TWkzWmNpakFGNld0TkhF?=
 =?utf-8?B?bFd3ZzViYVJpbHMzTnlrQ0FWUkZSUDFtYXJnTUdPTDhpczZRSHpHeUFvWlJV?=
 =?utf-8?B?QVV0Vm13bHZXdnVCWkNrejlVaEFSUi80SWR5cWFoc3hKRHB2aE9BQ2dTQlBI?=
 =?utf-8?B?MWg4eXU5aW90SVJVbHpNdmdDck9ueFNoZ1ZlZGhjVmxudENMamFBMHVwdkMv?=
 =?utf-8?B?eEhYVTZVa1lnQlRIUlJXYVBDa1hVdit0TUxqc01KVVBPWUh5WWtaeXBRN29M?=
 =?utf-8?B?WERIc25lVncwRURyMGM3QmpYVWhrWDdsdUF4OGVLVnIvbTMrTDB5elBGYnpM?=
 =?utf-8?B?UzB2bVVwc2pPbFgyNUMrUXVxWHpMWGZDTyt2TjF6MnQ3QlpSUTdMcHNrN0Va?=
 =?utf-8?B?MG9LdUpyVjNFWUY1dUV1WWl0akJRVWk5c0I1b1RiTU5YU2x0NksxeHJSSUs0?=
 =?utf-8?B?Q3l1czI4QjNhQXYyYUFzRTB4Tm51MlRhMkJtZ1l3eTFqUHRrZUtIYklVQ3lm?=
 =?utf-8?B?cHJoeTVrSk0zR3RRcndnZ2UzajFvdVlRQktZNTNVYW43V0YvT2pyY01Mb2VK?=
 =?utf-8?B?REo2NTRiUlBKOWg4NE5SZTl0UHIyblJWbk1LdXhXY3lIWmpWMzFCWjVUUThL?=
 =?utf-8?B?N1N5dGpkeEhZRmVBeVZMU2RwWjNpOHpxM1QwYkhocDVSSnIvZExTQUVRbEY1?=
 =?utf-8?B?NHNjak1EbkxvRWNUNmRZUlE5aUZZZlQ2YzlGZTkrcVJqaE13alFQN3B6Q1lK?=
 =?utf-8?B?M3RxYkJ0bmROYWRpLzJENlRvYTJkSlhrR3gvcUNIWkhPSm9la3ZYWDFhWHRK?=
 =?utf-8?B?dm05UGpGVUlEMGFEVy8zOFRHRCtyaEd2YkM4Wkl3SlIzNEpNRXJVZXBUak9z?=
 =?utf-8?B?ZFdJTjJ0WUI2YWVhZ3BnN0p0UUtFbnpKTWI4UEtNWTQ0M1ZKRVdNVXY4WHJK?=
 =?utf-8?B?NWNrdUVHNjh2dXJobmJpU1N4YXJZTjB6bTRuYWViRVRVaXAwOGN3emJWUURW?=
 =?utf-8?B?bzN6MVFXTW1MSVluNFJHODd1U1hwODAxMUNndGZRSGcrMG9uN2hNczRsY1p3?=
 =?utf-8?B?Q252UFhyQlpRSzJmbjkyeXZhRm0xT05WekJsQ0RZNnpHeVcraVJ0VjhMQkdK?=
 =?utf-8?B?T0lKWUJYcms3dkN0UVZhNWJ3cGVFNXlkeWdreVQ5NndoSVNWUHVTUXpkZHdq?=
 =?utf-8?B?TUYvYnBiZFR6c0JDU3FxTTBORzRaRjBGMThGSVluV21rdkNEUW40TVJyMWx3?=
 =?utf-8?B?YkZpaGtjZklLZUprdmVGb3RKYTJQUUV3enIwci9KbGV1Nk5oZ1NGZXNiMmpV?=
 =?utf-8?B?clpEQnVCR2dxS3h4MndXeWErK0JhdVNIUUJHWGt4WjRRcTExd1dxTFJGNjMw?=
 =?utf-8?B?bXJCdzZRVE8zd2VzM0ZUMVlYTnlmYjNlSlRwWW91Z3ZPckRRdTNFUnBIK2NN?=
 =?utf-8?B?RSt0RHFSUTRyWSs1N1dPSUw3SFlJREh6YTBtZDM1ZFJpOTJVVThoN3RlZGMr?=
 =?utf-8?B?dlZ1VDltcUlxTUwyUjVHRUVwQnBWdWpGMVJrQUdJamFlZStqV1RhK0NVWHFQ?=
 =?utf-8?B?WXhQMzZlcjBJL2pZVSt2MEJTT281M0ZwUFl1RVptMGoxckFDb1FrcWU2Mk4v?=
 =?utf-8?B?Mm85VTBmT3U0d2J6SDVVVGtKaGVjSUNtbG1WZFhHemFJano0c0ZtN1Q4RG1r?=
 =?utf-8?B?UTZpeXFkdWs5YjZkTDIrUC8rMXpVMnU4SU9vWEkwbXROdVVLWVdsaEt5dmZO?=
 =?utf-8?B?V0I1ZFdVS204c1lPTlNGVjF5L0c0MkNFeVA4V1c2V2pKV1FGZWpFV1J4aDJj?=
 =?utf-8?B?YkRzci9tSE90NnNad0d5VndYUDlPcnlSSjVRYTM5djVycWZKL1c2ZlZFTElW?=
 =?utf-8?Q?GLdFcBC2hjQNyWW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB3A227A5C9F64D9F0D91516F6D32A7@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lqFUqSdD4HIPNEfRUxYxr/Fgp5mRSYT2ur1FkS/Y/DnmC9BFkOC95X7i8l/GxHZylv0gCJShY6UwvBgHcY187dYmjRBbtRXvGutbhRZkBen7GeEoSlo7CSBhamQ7Fyl17nqjwInDv0z607Gi30pdqfnqPpc1HL0gK9hFOW+9EY/H1mQXWGIa6a1p1v/DJmjF/8niwcWMGz87gKOW3YXi6lZqHsAlEPdUWuemUnjdifRzxp0Urg6GRmBpWQ3RsRqeMsHxZm4SVyAh5TfIrIR2gtpOY0h6FJrdM20Qsr6dWTnUtaj3oJJl9dqYzjuUOiLrVbn/+0ExrGviMPzsXxF5iw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c10498db-a71a-4d33-e116-08defdcf44c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:52:58.6355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUxoSSvkee/Ui9ZD6ADSbRB0tU1i8qjKmGHzqmKeH9mw5oOJo/WGOskNbWq1G0JF6IGfbj8Ix/cI3YvaFhMNHkE+KnVlfxabDH0ua/JboWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3589
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2NiBTYWx0ZWRfX0eeA0Mma/3dJ
 WTNXBpF0Ao9kPHy6M+BZjNeP0pmJYglU4J5BqVScmvooLfZKQewufTFNQh2NijRzk5qmQCmjsyI
 PoNzO/RSzTSEZigos9aU4xTcLG9nYNVQvZuV1VwL3ll62HWEGaobgqUIWaug2XLWvpurxQYLy8A
 RE2Itn/NGxoYiprA9PoByPK0NahA06Z/vH7EiwBxA5UifAV0xNpOX4qDbSVZwCR3cfsDfhZ7kwj
 du7kr2iHCBLslW2+UMPefvBxAL+FVaX8O4zB8RY4Md+SIUPL2OgJIIbZSYPPa72MmXG96DRg/7w
 kGv2Y23cnmqG/LBilqvHbrLzocqeTlpI7j7kCSssLS1M7qYwVwtlK30kR0AJYEoDWjAMCSn+DAx
 RiywEvhi80CiySz1x/pWE0kq/cbWc0wjt+2IxBXcAFRqeS7gfCEZzxB7f4zJngDdFdyn4AKd43r
 VCaLYWQb2cizfxk2yow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2NiBTYWx0ZWRfXwW4kJNJdgeZ8
 8NzxPi0pIms3ZVvh4+k8fs1cy5Bb2dX2Rc9YNSJ9Rea2k+DGB6bOLLwFEZCGer8e+jlcHlyZk35
 lgtzTk2TWAfLSQ4+NQw65a/Hv/xLvLQ=
X-Proofpoint-ORIG-GUID: RkBFls8OGNq0gTOJN1YR_7x3RzdIebYR
X-Proofpoint-GUID: RkBFls8OGNq0gTOJN1YR_7x3RzdIebYR
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a856eed cx=c_pps
 a=lKm+19O5CcsGltefyTrg/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=gAP7vKOFN5buYAs6P6wA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE0OjQ2ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIEFsZXhhbmRydSwNCj4gRml4IHRoZSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgZnJvbSBw
dnJfZndfb2JqZWN0X2Rlc3Ryb3koKSB3aGVuDQo+IGhhbmRsaW5nIGFsbG9jYXRpb24gZmFpbHVy
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVA
aW1ndGVjLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3
LmMgfCAyOCArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl9mdy5jDQo+IGluZGV4IDg1MGEzZWM4ZTc3NS4uODhmMTFmYjAxMzA0IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+IEBAIC0xNDI1LDIyICsxNDI1
LDI2IEBAIHB2cl9md19vYmplY3RfY3JlYXRlX2FuZF9tYXBfb2Zmc2V0KHN0cnVjdCBwdnJfZGV2
aWNlICpwdnJfZGV2LA0KPiAgICovDQo+ICB2b2lkIHB2cl9md19vYmplY3RfZGVzdHJveShzdHJ1
Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqKQ0KPiAgew0KPiAtCXN0cnVjdCBwdnJfZ2VtX29iamVj
dCAqcHZyX29iaiA9IGZ3X29iai0+Z2VtOw0KPiAtCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2Vt
X29iaiA9IGdlbV9mcm9tX3B2cl9nZW0ocHZyX29iaik7DQo+IC0Jc3RydWN0IHB2cl9kZXZpY2Ug
KnB2cl9kZXYgPSB0b19wdnJfZGV2aWNlKGdlbV9vYmotPmRldik7DQo+ICsJaWYgKCFmd19vYmop
DQo+ICsJCXJldHVybjsNCj4gIA0KPiAtCW11dGV4X2xvY2soJnB2cl9kZXYtPmZ3X2Rldi5md19v
YmpzLmxvY2spOw0KPiAtCWxpc3RfZGVsKCZmd19vYmotPm5vZGUpOw0KPiAtCW11dGV4X3VubG9j
aygmcHZyX2Rldi0+ZndfZGV2LmZ3X29ianMubG9jayk7DQo+ICsJaWYgKGZ3X29iai0+Z2VtKSB7
DQo+ICsJCXN0cnVjdCBwdnJfZ2VtX29iamVjdCAqcHZyX29iaiA9IGZ3X29iai0+Z2VtOw0KPiAr
CQlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKmdlbV9vYmogPSBnZW1fZnJvbV9wdnJfZ2VtKHB2cl9v
YmopOw0KPiArCQlzdHJ1Y3QgcHZyX2RldmljZSAqcHZyX2RldiA9IHRvX3B2cl9kZXZpY2UoZ2Vt
X29iai0+ZGV2KTsNCj4gIA0KPiAtCWlmIChkcm1fbW1fbm9kZV9hbGxvY2F0ZWQoJmZ3X29iai0+
ZndfbW1fbm9kZSkpIHsNCj4gLQkJLyogSWYgd2UgY2FuJ3QgdW5tYXAsIGxlYWsgdGhlIG1lbW9y
eS4gKi8NCj4gLQkJaWYgKFdBUk5fT04ocHZyX2Z3X29iamVjdF9md191bm1hcChmd19vYmopKSkN
Cj4gLQkJCXJldHVybjsNCj4gLQl9DQo+ICsJCW11dGV4X2xvY2soJnB2cl9kZXYtPmZ3X2Rldi5m
d19vYmpzLmxvY2spOw0KPiArCQlsaXN0X2RlbCgmZndfb2JqLT5ub2RlKTsNCj4gKwkJbXV0ZXhf
dW5sb2NrKCZwdnJfZGV2LT5md19kZXYuZndfb2Jqcy5sb2NrKTsNCj4gKw0KPiArCQlpZiAoZHJt
X21tX25vZGVfYWxsb2NhdGVkKCZmd19vYmotPmZ3X21tX25vZGUpKSB7DQo+ICsJCQkvKiBJZiB3
ZSBjYW4ndCB1bm1hcCwgbGVhayB0aGUgbWVtb3J5LiAqLw0KPiArCQkJaWYgKFdBUk5fT04ocHZy
X2Z3X29iamVjdF9md191bm1hcChmd19vYmopKSkNCj4gKwkJCQlyZXR1cm47DQo+ICsJCX0NCj4g
IA0KPiAtCWlmIChmd19vYmotPmdlbSkNCj4gIAkJcHZyX2dlbV9vYmplY3RfcHV0KGZ3X29iai0+
Z2VtKTsNCj4gKwl9DQo+ICANCj4gIAlrZnJlZShmd19vYmopOw0KPiAgfQ0KPiANCj4gLS0tDQo+
IGJhc2UtY29tbWl0OiBlNTVmZWFkMjJmZjllZTA0N2FiOWYxOTAzODYwYzRiNDMwNDM1MTRlDQo+
IGNoYW5nZS1pZDogMjAyNjA4MTItZml4LW51bGwtcG9pbnRlci1kZXJlZmVyZW5jZS0yYzg5MTE0
MmQ5ODgNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxl
eGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4gDQpSZXZpZXdlZCBieTogQnJhamVzaCBHdXB0YSA8
YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQoNCg==
