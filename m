Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A564CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF68110E109;
	Tue, 19 May 2026 08:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Nue88ZGH";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="latDWgq8";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A3410E109
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:30:19 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5ChhG3726559; Tue, 19 May 2026 09:30:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=809pM6Nk0sg4u7prBrFLV/0dE7JQlfzRrBPqxu3WbgU=; b=Nue
 88ZGHTgtcoqbXbXaJSTgN5MCoDUCCZnNcIW++hlKQBe1HmkEJag4t976EfBFMvfa
 /LpAdRYXFmANHsgVEgJxZEZ4q/4lRvbIxZr9GXqeWrThaEwH/xg3sccys1/aps2o
 DH+aOdh/7rhW9TZ5AGitkmftzKx3Wk4ZR8pUqnnFAGAG6GpTWFdSlBQe4l6Fj2Yo
 7bIZ6xsOtw33s2aGVvC3Ghf31odrpeiDyVDxdq3srGxeNOqd2UzZ0Cq2SySg/PRA
 WALWk0l8Stko9jLq0Oso4XYgsDX3UgKibFqmrMIFcfW5vC/XrSMa9e1VyFVnBcpj
 qElNDavDYRSvtjAF59Q==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup26vq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:30:10 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isNbMiMkOQNLqqz6oYSR5B2XZoSTT9P45C8diAjLH1O33bs/GC19yB0K5/l2hnz/Kz5oy/K7+aSua5dlLe5qqf9G9wsPE57/9XNNARwYD6MM/INvR1ElF0TP522bhtCRX7E4/t1Zku0gJsXcdQ/8l6xg3lK73wzSOEm1Fig7rpWX2t+3KBV4IoYAn0oC6NVlawPaKrcsiXrgj8pn7XYRBGA1e+fwSYLtpAWhPZjPhFoquoRJdhYV7K8XR39fq9ykvZAObidNvTmNsXXmizIIuQQnWeV90N4AmIniDu71tYFImG9ZHroMk3zLd7RTI7UPL1z2qdq5RnM89Pw+fU4A4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=809pM6Nk0sg4u7prBrFLV/0dE7JQlfzRrBPqxu3WbgU=;
 b=MiIjd2ECiwPLOsnHjn1QstbzIJf5jwNp2TVfktk/Es8QMV4rrBcAkEyT2p6BKLMe6JjMk99cAnYIpzj1fuXGKa9r23wy/4FtnAfQ4ujBzH1bUiYo/HX6VOE4UY45HnezW4dykGhFciCagAgPOTe1/DQ5PJTEhNpG3hd3Ii0dpkXm/PUR7Mac41QWEjVUys/KzJuGVC/n+dtX5hDhIGwXymWLN17UKzjoM6jhNljAMgeZCdXD/J7Fbda+FaQzJXYsiI+xMgTxctk1t9InQLYf1rpo4FQLnPR1D8kSsRLIFEoDnfKPJWTsnJ6ewC8JQ1tay4frT2QgurkrSCxzdbK3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=809pM6Nk0sg4u7prBrFLV/0dE7JQlfzRrBPqxu3WbgU=;
 b=latDWgq8mUNRTNuMOB8sKtSb8SSxo8DeYKINqeAxrqrDfcJ1Eny9WYTtcxth49bPhfnuqdXTX0uGnx/Fus7v233BYofg7Jvh0lOoXC+629DnwxlzXY9Z4blv26azC5HAAzaBOEvwLFNtO+JONKtRoDPxC+PDCk/02ZBFMK8kNU4=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWLP265MB5691.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 19 May
 2026 08:30:06 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 08:30:06 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
Thread-Topic: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
Thread-Index: AQHc4ds3O/puIwOSpkOQKsthxroyxrYT6s4AgAEkwAA=
Date: Tue, 19 May 2026 08:30:06 +0000
Message-ID: <e4252a9a0f66beba26782dc73d71470dbd0c8d7b.camel@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>
 <1d579aba-af9a-4d31-889e-9582a362468f@imgtec.com>
In-Reply-To: <1d579aba-af9a-4d31-889e-9582a362468f@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWLP265MB5691:EE_
x-ms-office365-filtering-correlation-id: 254a3727-1e23-4b9a-c79c-08deb580d500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: u7xG+KPibBDmMG6B1oj2TRnLjkIzMNkCNw27YHcZbfZ8q7g/+DkMO8p8xbMluRNPEzzlHGHqW4kumGKgKHtxuB2kpuAIgG8RUWMUoIwdiYIK3CrT9Zh+GvP6UvzLPPoEvSzzvKytkLJOL2TXWjbed3A9/YHMo3a6cUuKrv+v0+JsPgphsp+viB8x/ciBpmmXlLUTUyKdnWIphbquSthUbA6W0MHk5taBkgaSMCII10vE9CRs33YPY0wBPCOd7aF4rrD2Frpd0XwmGdrRkv6BhU48cUBFxaS2SWvtJvastzRaDIE6+SkeUHNkSlo/1wSClk6SzAuR8cmVzhpVTITAIkEx1mHWWxtnvu1PXe0QW4ysxYHARZVXdWysJVbYK8l8kwUDbQKKZPYDSw0VyY9+IHeKnlp9BEr3BNKKvUi1s1i+TzGP5GoXB244DxDVeBu6lQPqEB11JXGFuvkwOHB9nQDACKlh9GrLEi1+4R5GKY4MPyO6f9RHXBLn/hkBPGZZTwFx0SsmFGhFB5aKz9uRbGiexbYwUD5ZPhpKYeKNxzjvth/1yCjtRBobMfhYGhTk0KVYmfWu0m4fcjc1BbXZBzfXeF0Vi81szn6jDGMw648cFYv9HDI2Z0ytMPjaLEeyNLtsYPweNEFQJ5AN8bqNStC7xIVWjCiqmY1wwt6G7ZMq9XV/MHwu2nt8AoS4uu4Fs9QOGB17wRcGcA4NVF4/WFSd3XadIeLgW5WpMvnVa/Y+PsYREQ+i72WdAAuGidD5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZExPN20wNmJtUlRlZUw2aW1CMnNvMTVYWHBDUTdKRmxrVmI5Si9hblA2Nlo2?=
 =?utf-8?B?S29HVjd4ZXhONi9ENnljMThvMlpsN05UTjlrcW9sSGp2L3lYRkZUYlVGQm5C?=
 =?utf-8?B?QkVIRFplRWFadFU1NXJySVFVSkpib1EwZ0dhSzdXeXFGazFUWUFmaUdxc1V3?=
 =?utf-8?B?c3lESnh4Qk1ydUNjTUt3VUdUeURMZFY5QjVOeDU3dG9sdVdoUm9KUmN1aGJG?=
 =?utf-8?B?bGtGTUVaL0t6NUR4QXJZWlVmUXM1Q3paS285N1N3YXNSNElMNFl0Ti9qdWtx?=
 =?utf-8?B?NlQyV2tDYzVNYUtIZnc1YVhTRkg3ODc4YllUQjVwcVJCSFJDN2VPYlNrc1Fh?=
 =?utf-8?B?a2ZtbCt3N1M0VHRIT3oydnI1TVU3eERvWVdieWx6MzZTY2VWTUg3RXBIcnAv?=
 =?utf-8?B?RnpVQkhXQWo0dXhUblVGQ0VTQmdsTU9kSGcxa2VkcEtpMTFTTURUTUZBdUp6?=
 =?utf-8?B?NC9XcmMvMTNBUmdwTkp5RHdLa3hBazdjeVFBM3FNb3N4SFNjb09VU25VZ3I4?=
 =?utf-8?B?dnptNE1YUndSZlRaODRwbFVybUZIU1BTd3A5LzB3Rm53RlRQZW9CTUc4VTk1?=
 =?utf-8?B?MkpNUHZBb21lMHRsTnZZSGt6ZkZ3TWcvRW1NcFhHSUFaVklEcFRldzFhOC93?=
 =?utf-8?B?TTdXZC9uaTNlYUJsRHoxTmZKYng0Y3Y4eXJYUWN2UmpQY05QeDZtaWhlTmw2?=
 =?utf-8?B?dC9PckFBR01td0VGS0tDdnRSRlBYdFAzVkxRVnRHYjY3TGk3bUF4SHFlRzN3?=
 =?utf-8?B?MkViV251bUY4aU14NUlpU1pmSFBVSW94YlZmU3hIK0pXc2VnK2g0QjdJbFJk?=
 =?utf-8?B?N3ArOVFWbHE1UUZUbERCM3lkTStjdG00YmU4UjRDaUF1ZmNHQ0dkQTUraGk2?=
 =?utf-8?B?cThFLzdKendNZHFwK1pDLzZlTWZTa0tmZzBjQWVlNGg5MW1VaExrY3pJSmdM?=
 =?utf-8?B?dlRodFQ1ZUFmNFNmS3FaTHAvYVBPSmQ0bGUrYlVJa2p6TXF5QkN1dEcwZUJm?=
 =?utf-8?B?ZzNaWmZpOEFlL2lyYVp3MFlwZmRpVEVSQk00ZXBhRnZTczhOc2tpb1k0VGpG?=
 =?utf-8?B?WVl0c1Q3UE1Oc0o4TVVlNzkvZ2J0bjQzVGVrT3laN1d4UnRzLzB5UlZOK2Mz?=
 =?utf-8?B?dzk5R1hUN1I4aUpGYkUyZkh0TG9xL0cxM2JPUi9XcThoZENKRkdkejA5VkdD?=
 =?utf-8?B?S3lBRHVobDNvWXdiWkZ1YVBBR3Y0OWo0RlVLSGNvOU9iQTBsODNmVGpVN0I3?=
 =?utf-8?B?Zm5xeXFrU2dtR1h3VEdBRTJPSGNmbmJSdjhEMWQ3VDNvRHpKeVBEZFNZZ01Y?=
 =?utf-8?B?Y1Q4OGpYMGd3VEcwTWJOZjlFbHVUQ2w2c1FtZVh6cXFTdE1sQjFhNEt0MUNI?=
 =?utf-8?B?UGlGeXEzcFJ2VXUxd2gyNHk0U0RkbkxjVW1UQWVkSlhoSThiVnY3REVuWElD?=
 =?utf-8?B?RlhPRCtYWmhGd0xMRXFzOUN3L1hxa0kvTDBXbER2eVlmalEzZGhlMGYvZHdi?=
 =?utf-8?B?RU9ER1dyVS9odzYvN2JDbnVLUWxaTUd2dVZqcm5zRnRSS2FoR211RjdpUmF3?=
 =?utf-8?B?MFd6bW1JL2VnR2lWRkVTMlBRT2pseG9QSFN5WmdzOWFUVDgvRElXY1Y1UFAy?=
 =?utf-8?B?bmRsZUczWmZ5Y3BwNVVBenVyc21sZTBJWHNJa1c3cVBuenFRQStSTktZYXRS?=
 =?utf-8?B?aVBMT2lPRTVNK1ZyU0ppeElXV1d2WlFXakN0SU14OStMa3BsdFBWc2dWdURn?=
 =?utf-8?B?RmhoTjRMTHMrR1lUNXdlK2NQKzBjYXA5d2VBNndFYXRIaVR0d1NNMnVTSE9C?=
 =?utf-8?B?UzMwVVkwaTFkWnM2TEN2anVwOEdVYnVMOU5YR2ZlZGZjTFl4cUkySWI5anps?=
 =?utf-8?B?endYM1FkTG5kWFVCb05jQVZEME5BMkJ0TFZvODY0cy8rUm9ubUliSFBCUWUr?=
 =?utf-8?B?ZHd1bTB4UGRVUHdUZEUvWkdCSWtBNHJEaDFrZW1PSEJMSDFGaXRKL3ViajJ3?=
 =?utf-8?B?VFlkUWppeHBRMiswQXdRQkNlcmJTV0lUVk9ESTFNTE91VGdOWlhVNlBZbVNI?=
 =?utf-8?B?MzRiR3dSaVVMNzIwM3h5U1BkYnZXRGJPUGtzakZ0WHpGZXJhZjZjcWJITnJo?=
 =?utf-8?B?NG56SjFCa29PK2U3TUx2QlVyMjdQRzRldTFnOHFMLzJpMEh4QkN2U0FwMitq?=
 =?utf-8?B?L2RSY0NxcE1LVTVJNUpTK01hdWErbmxyUURRZ0gwVXMvdldMamNMWktzT1R6?=
 =?utf-8?B?b0hSZEIzZjJWY2hqNGJJNVJrMTA0c2x6bFJ3OW9NNThlTUNOcURqMG9rUDh4?=
 =?utf-8?B?dC9XUWczV2hKTGE4RnhHWTg2SlYzTDZuQ3hXL084cGpNMk8zbXZWcG81SnBO?=
 =?utf-8?Q?dqfxrYIeDoCjXTG0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F367F520C05E5E4DA8D2AEDC1AB9900B@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EThn3w+u/qRp4UzvShhYRfvBOTMrpMixg3P8u6Og0+/vJUPe7ksz2LfhuL9Z2iRaCLh3JQJIeGa2ftsfPCQUCg4d5wGvuGMQSaDj+nWEI3Ux/kCcGX6dyBIH/hWvPD5GNLzyoGdHLMMwgOBUZTKqUK897MhoK49+FNiMERN+1omgzeT1C05AigW590L4dsj+nvXGJZrXDkhdp3N5DqnYJlPVYNGvpHwORW0zByJtL63uAb7nuvoEmBq73zQ0CG5cS1Yeath8robFJ03VG+/DhyIBEaJuNvYExOPabZFHKMJgHJS1SJUUnJ0BWoPoZaJNETzFuu11Ugr9RgxxO2hYLQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 254a3727-1e23-4b9a-c79c-08deb580d500
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 08:30:06.6638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e470qiYx5Qht8gkMF/MYFk/dgXP8MGzzPXQ1pIvv1GYOaXUyWlgHh4iW60aaESanRFkE6LodQg4TQuyiLeS9wG51KAht4FmEjvBizOm6tS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5691
X-Proofpoint-GUID: WVznM51y0ZrAO8Xkp283ytOvIQakIy2S
X-Proofpoint-ORIG-GUID: WVznM51y0ZrAO8Xkp283ytOvIQakIy2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MyBTYWx0ZWRfX597EM9HebHBA
 Ws1oGwueYht+dvAcuxzJP5sWZGiRuf5siDpgIjHJ6Tetu/U7/+iNzuJQW+NbsfFJ4Q4knRQVXdn
 WYnciBodehXkVfrhgOM5pfM4VKuBAZa3licetLY4BR/Ag5DsTYXxGmI6POM4Tuc5CdhTBrzF9t4
 zIjF1tQaWMphiuqZSa2pZSo5xpf6VfBaq3J68mKpxYJQc2QY6IEYoQDipsn5MfURsqToNMeUS4K
 y8ebPy9ngjGxjzoWJkJh3BIcGERtbpsctHE5IhrMgW+JX4S2qb+CEshQrfyf/FYuOEnxSuzVrfa
 2Zk7XXt0V5kufWdSu1hkIccgyJbuauqiwEZIl9Zl8Lg0M71Ir2KcB8DcrVto3RMmikh8Kk5BalH
 F4KnypmiR9Cx99a/32wR7dN79AwKHxjauiDJoHU2v8RDvGqiBjZCRC+4iFmOQ9VaBeuqlS3N2IT
 gsVkcdL2B/cwf13cLjg==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0c1f92 cx=c_pps
 a=AAXxRdAQmdgPLU7KzgPeYQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=JvALK-VZC91PjwJHCI8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjAxICswMDAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
SGkgQnJhamVzaCwNCj4gDQo+IE9uIDEyLzA1LzIwMjYgMDc6NDcsIEJyYWplc2ggR3VwdGEgd3Jv
dGU6DQo+ID4gQ2hlY2sgZm9yIGpvYidzIGZlbmNlIGluIHRpbWVkb3V0IGhhbmRsZXIgYW5kIHJl
cG9ydCBOTyBIQU5HIGlmIGl0cw0KPiANCj4gTml0OiBzL2l0cy9pdC8NCj4gDQpVcGRhdGVkDQoN
Cj4gPiBpcyBzaWduYWxlZA0KPiANCj4gVGhpcyBjb3VsZCB1c2UgbW9yZSBleHBsYW5hdGlvbjog
X3doeV8gaXMgcmV0dXJuaW5nIE5PX0hBTkcgaW4gdGhpcw0KPiBpbnN0YW5jZSB0aGUgY29ycmVj
dCBiZWhhdmlvdXI/IFNlZSB0aGUga2VybmVsIGRvY3Mgc2VjdGlvbiAiRGVzY3JpYmUNCj4geW91
ciBjaGFuZ2VzIlsxXSBmb3IgaW5zcGlyYXRpb24uDQo+IA0KVXBkYXRlZA0KDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMgfCA3
ICsrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24v
cHZyX3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMNCj4g
PiBpbmRleCBkMTBhMTMxNzNmMGYuLjA3MzQ3ODkxOWIyMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX3F1ZXVlLmMNCj4gPiBAQCAtODUxLDcgKzg1MSw4IEBAIHN0
YXRpYyB2b2lkIHB2cl9xdWV1ZV9zdGFydChzdHJ1Y3QgcHZyX3F1ZXVlICpxdWV1ZSkNCj4gPiAg
ICogdGhlIHNjaGVkdWxlciwgYW5kIHJlLWFzc2lnbiBwYXJlbnQgZmVuY2VzIGluIHRoZSBtaWRk
bGUuDQo+ID4gICAqDQo+ID4gICAqIFJldHVybjoNCj4gPiAtICogICogRFJNX0dQVV9TQ0hFRF9T
VEFUX1JFU0VULg0KPiA+ICsgKiAgKiBGZW5jZSBzaWduYWxlZCA6IERSTV9HUFVfU0NIRURfU1RB
VF9OT19IQU5HDQo+ID4gKyAqICAqIG90aGVyd2lzZSAgICAgIDogRFJNX0dQVV9TQ0hFRF9TVEFU
X1JFU0VUDQo+IA0KPiBUaGUgZm9ybWF0dGluZyBoZXJlIGlzIG9mZiAoYW5kIHdvbid0IHJlbmRl
ciBuaWNlbHkgaW4gdGhlIGRvY3MpLiBJDQo+IGJlbGlldmUgaXQgc2hvdWxkIGJlIHNvbWV0aGlu
ZyBsaWtlOg0KPiANCj4gICAgKiBSZXR1cm46DQo+ICAgICogICogJURSTV9HUFVfU0NIRURfU1RB
VF9OT19IQU5HIGlmIHRoZSBqb2IgZmVuY2UgaGFzIGFscmVhZHkgYmVlbg0KPiAgICAqICAgIHNp
Z25hbGVkLCBvcg0KPiAgICAqICAqICVEUk1fZ1BVX1NDSEVEX1NUQVRfUkVTRVQgb3RoZXJ3aXNl
Lg0KPiANClVwZGF0ZWQNCg0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hl
ZF9zdGF0DQo+ID4gIHB2cl9xdWV1ZV90aW1lZG91dF9qb2Ioc3RydWN0IGRybV9zY2hlZF9qb2Ig
KnNfam9iKQ0KPiA+IEBAIC04NjIsNiArODYzLDEwIEBAIHB2cl9xdWV1ZV90aW1lZG91dF9qb2Io
c3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ICAgICAgICAgc3RydWN0IHB2cl9qb2Ig
KmpvYjsNCj4gPiAgICAgICAgIHUzMiBqb2JfY291bnQgPSAwOw0KPiA+IA0KPiA+ICsgICAgICAg
LyogSWYgZmVuY2UgaXMgYWxyZWFkeSBzaWduYWxlZCB0aGVuIHJldHVybiBubyBoYW5nICovDQo+
IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgY29tbWVudCByZWFsbHkgYWRkcyBhbnl0aGluZywgdGhl
IGZ1bmN0aW9uIG5hbWUgYW5kDQo+IHJldHVybiB2YWx1ZSBhcmUgZmFpcmx5IGRlc2NyaXB0aXZl
IGFscmVhZHkuDQo+IA0KRHJvcHBlZA0KDQo+IENoZWVycywNCj4gTWF0dA0KPiANCj4gWzFdOiBo
dHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5odG1sI2Rlc2NyaWJlLXlvdXItY2hhbmdlcw0KPiANCj4gPiArICAgICAgIGlmIChk
bWFfZmVuY2VfaXNfc2lnbmFsZWQoc19qb2ItPnNfZmVuY2UtPnBhcmVudCkpDQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiBEUk1fR1BVX1NDSEVEX1NUQVRfTk9fSEFORzsNCj4gPiArDQo+ID4g
ICAgICAgICBkZXZfZXJyKHNjaGVkLT5kZXYsICJKb2IgdGltZW91dFxuIik7DQo+ID4gDQo+ID4g
ICAgICAgICAvKiBCZWZvcmUgd2Ugc3RvcCB0aGUgc2NoZWR1bGVyLCBtYWtlIHN1cmUgdGhlIHF1
ZXVlIGlzIG91dCBvZiBhbnkgbGlzdCwgc28NCj4gPiANCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+
IA0KPiANCj4gDQpUaGFua3MsDQpCcmFqZXNoDQo=
