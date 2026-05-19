Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1798ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA2010ED65;
	Tue, 19 May 2026 15:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="h0SABSQc";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="BHv5FJmC";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357BC10ED62
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:10:49 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEZorj556149; Tue, 19 May 2026 16:10:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=1xfL+Mn3jvS+IYH7UBUXZdNIQ2BEppWaocoBWvTrf1Y=; b=h0S
 ABSQcoiEVGGmYLbnlgTUarjWhRfS8nV2ig2UIh4PQDYH9cHrsjMP5G8RszDcax4L
 l5Pvo2W8MwlnEanPbg7RAbFlJNQuqGv9BkR8jRpfL5OV2AXwc/sPiRVbas2N6jai
 YJGxjVfGP8xV6KH6u59Fa69F1R9zYI1Ow1naJItjlHmT5Lzl/45pu0OBlJFmBAdW
 wE25E+059TN0wZvhK6LlBWxw6tqP7S6d6EpoLhYwCnZYmPNrE9EW5NXY/cR2ZRiG
 rlSZj0DS91bNUHWRBIeKFZDNIy/z+CRCdeAqZwWYtytgZzJL48uRbEzB+D4drUuk
 50SVrJC3Q9jbo0tDCHQ==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021130.outbound.protection.outlook.com [52.101.100.130])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup2gxw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 16:10:35 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1MMEzXMP3nn+25rBkqHKvKE3uQ22bb1y3qWAAYovkflm9yYmyR3hvp0aECU9gexO0cjovjZw/4U0iHjYnWnZzC8148jfPccJwgUfIOW8aV/McMgKEzeHEaK46ZR2P3d1i7zxMpE3I4PufDvdWjS8uK096VVB8ceWCj5vSZrsB0B9n8cWAs8FLeKbzwCFQ3RLlZxHm0CXEiYRkPX95uHdF+l7h91AV6KFLfZx91jFXMoDnSD8eAPWgI1iTWUUEjaA0S/SY+fFX8Z/pdOgeBnTpZNr50rGoY3sTYFXSljcBKh9DWTRNcY4OZK112M6mcConKumVkkq/jPKN/WH7m4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xfL+Mn3jvS+IYH7UBUXZdNIQ2BEppWaocoBWvTrf1Y=;
 b=Uo6rvXHPvknovTUJ8OhibVREmbCU6yslLFNfgjoVRomdWqci9MzGAKyuJkaCue68RNBg8c4PS8A/Y8DU0RbSIFMiGqUWzif/SKZjRtRGszROv9t3qq5LHhhtiVEt+KLpPD+nL/uCfelNDqpVw/5wCswjv10khp7HXWpa/6VS7BZQsaF19rhLGIHqvwbbQW5L4syjAUvbtoc43iZDVEr50Ea7C1DSbeiQFjhH/pv25h8My0KuZbIxrozsjwYQu17BaRZcb7mQxlJopoprVf7K+khGfn5juwwRKa9DN7OBxWyr0HRDtH7DSbOnKm9Y5n7J62MZqFFWi+fUG3jt/2ILvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xfL+Mn3jvS+IYH7UBUXZdNIQ2BEppWaocoBWvTrf1Y=;
 b=BHv5FJmCgXmqrEYau9ySqhBqbGamkE7EQexdHv2Vfg96f84ZS0YU0p1j5ggY5jTtHS1S6B/LOml8h6ynShvJrCJAww0rTp1Ybb1rDAzsLU6Oal1sLIHiTyGzeE+4Jvt3cKgV2HUkwg5/CCAAcqPT7nF7EDIEsyo/WGkQQ8VJkyg=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by CWXP265MB2216.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:10:32 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 15:10:32 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "javierm@redhat.com" <javierm@redhat.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt Coster
 <Matt.Coster@imgtec.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [EXTERNAL] [PATCH] drm/imagination: Fix missing
 pvr_power_fw_{en,dis}able() argument
Thread-Topic: [EXTERNAL] [PATCH] drm/imagination: Fix missing
 pvr_power_fw_{en,dis}able() argument
Thread-Index: AQHc55EzCNgNo9s1pEaKI73eg7Py8LYVdAeA
Date: Tue, 19 May 2026 15:10:32 +0000
Message-ID: <5b44cf26b7aae3a35db54492e9c093a3b3fd9342.camel@imgtec.com>
References: <20260519131239.1291732-1-javierm@redhat.com>
In-Reply-To: <20260519131239.1291732-1-javierm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|CWXP265MB2216:EE_
x-ms-office365-filtering-correlation-id: e6d5a2a1-d44d-4efd-4441-08deb5b8c539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: nli2KV3bvmyS+q5mfZ2ngkibgsaXKZQd95wb0/6TuY4eMcFCgyoZWz3rd6XeY5a/z2clozeF6eefTFN3NSL556fJtZRpHB/kGrYjn23uzBj/0ftoOMBBnJxc7YXKt+lrl82IC6TRzCDXwDBRz/Vvb74xm11d22kuinOf4T2CxWvWkdMSGou7zs0hF+C8H5l2O3JIJt+/RSgsN2BEDs7azd85qpvrPRV6hv/E+DF4LxcqFoVEQFv3MzJ+66n7pW42TvYHz5hWGvOx8JEa6tnktmTWJYoDZQia6/5XonOTh4x+GElUC0FXuKPJ98LeegKOJX4Vw+t3IAw42CtJcKFRodEpOwsdRj8grMWkqdwFZUvpFc5ROYF1SswEu9G8PHqf7syXjSRgGVp7zbHLIQ1+FxndrQBNvA1gAtXKbXToFUQfPX3pBmw4pHjR4c+515qQX6QWzpzRBPjt8OWECItKYuQSz3300IKxHdR1+zVd3raTPntrxCtP11QCF8U7IUw7X4bhabJIIXFuYZuEoIqzCuZtjc5S3JO7g+IcVHmoetgVMIzZcX0RCOhgrzoRNi8qAYU5BB4J3MkAWqYc9HF8IwI1HEzMYtjKNe+v1xWDIBkJ/eXMGbhzETMHEfugxsGXsassHCUcnwRPdjpPVgU+0QjagXCucj2HthNiwg05fM0MbPVXF+FSnUzjwOYFHQ67ZUMNC1ZoxVnMN/I4OvVY0m6vAXM4WjnymTpBRDFBRPH0wx1YbTFQWFflPGKX/5Dk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTRFdVljY3RCNXpNbVVMejFDU0o3eHMyZDdnU2liOXQ5ZlpFUnhQM0RhcG9a?=
 =?utf-8?B?SVYvc3hIdFZrTGw2VGh0VXovYlB5OWRDbzk2WDVkNThZZXNYMlN1cURJZ0JX?=
 =?utf-8?B?QmtqSndSdlRMTFI2ZC8ybHhWREZDVS82ellLcGJkandlc2N5bFIrekhGTld5?=
 =?utf-8?B?U29QRUZwaTh5cmNwY1FIRnk3UmU0TmoxWU9seURyYTZCcm5BSG5SN0hxeHBn?=
 =?utf-8?B?Q3loMnhBMkhoUWVSNTRTbFg3Y3hrYU1iYk93bEx4TUhiTE5mbVh6MFFYRFlu?=
 =?utf-8?B?Vjc1NkEwSFU4UzREcFFlbUpUWkUrOVhJZnJETWIwY2pBdVo2NlBrS0Y2YjNH?=
 =?utf-8?B?aHJRWnh0WGRmSWd5ZnFVbFFMeTdpb0xKYUpMN09FVTRQUS9GblBlZ0dwQ3Rp?=
 =?utf-8?B?bTJIU1V4Y1l1bjNWYnRFTkJCTDl4NlpCRnhCeTJzRnVGa0Qvek1Xa2dacjY1?=
 =?utf-8?B?SnBWeWhNS3hWZnR4RmpzZlVHSTF5UnZ2Y2ZYdG1QQ24rdVNhWjlBK29EM1VW?=
 =?utf-8?B?eG9HcUFYSFl0V1FxR1haNzdKelcvU3R0M1BRTHRVS25QMFljTFBOMG9Md3Zw?=
 =?utf-8?B?cDVvQS9PaTNQQitCV3hNYWQybExEMjJTVDJyUGxMcGhPZk1IbEYrVEIzTURt?=
 =?utf-8?B?VkN2QkEwR0JaWVRXMStLWXRwbHpHSXZmcGtOK0g2WEU5dG1LREwrNFQ0ZHQ3?=
 =?utf-8?B?cGxhT2ZENTJQS3FHclJOWUJCMll1TjlzRG9TZjhhSGRBSDZMQndTM0JkR1ZS?=
 =?utf-8?B?S3NHR0tpTUN3UW9nMUwraFd4dzJXbVcwOHBMemdYaytHZS9tZTgyU21zSGha?=
 =?utf-8?B?RmgxaEZzYVlwRVlKekdWOUczQUxva0FIbmdocmpMOVZkV1V4cVA3TVgrczcx?=
 =?utf-8?B?WGdvQXduMFQ4SmswYUNFVmU0YzBHS3NUcEQ5TWtDWU5oUjFna2xrNHBBYklP?=
 =?utf-8?B?V1YxWXUvMjFqd3c2b3BNRXA5cDNvTGNISmxpZzZYM0hEL2RFWkwrYytWRTB1?=
 =?utf-8?B?QitqUGtwYUQ0Z083ZDVYUWQxTkZYcWcycDZ0Z1Y1TWZzWkczRjZkREtyUTlS?=
 =?utf-8?B?RXd0MURiQ1dHK0p6Z2lkV0tUbXdEbFBjVENTbEpmRUxUVERPcGdiMEFWc0RD?=
 =?utf-8?B?UHVYOUk1MGhJV3VFM0RJODdKODBkanFxTWdBMFRDUjg1bWcvSEpzdCtTWnVO?=
 =?utf-8?B?eUdhSGhNZjRKMW82a0tROXlMbXI4d3BRY2JYYjhTQkVzYVNDUnZmNnh2QjJx?=
 =?utf-8?B?TGZVYlFRRE9QWGN2WldGek9FU2JSQ1UrZkZWeVRzSlkwSFp0cEJOY1hTRlNp?=
 =?utf-8?B?UFBYMXAydjIwbVllWUI1czM5UHhCQlVhWHozQkdrQkdGaUorall5WXVvSS8v?=
 =?utf-8?B?WnByaEJ1b3FwR2xBS3NibDBHV2k2c0NSUDdoWS83ZXFQbTY2Y0g0eDY0L2Y1?=
 =?utf-8?B?Rk41bHc1ZExIM0FqUG8wMWVSQWQyRGhpQkNQbzZvM0JIN0lvRUZNQmxpQVlp?=
 =?utf-8?B?enNhcUw5eUNweFBBeFZzT3VpeGhiYWNrUjJQbUZoMHBuK0FGSlJ5endGU2ls?=
 =?utf-8?B?MW54SUhFNUdhQ2FhSlhBaE14RnFBTUtyOEtCNjVRbm45NzBEV3M5SitsMmpM?=
 =?utf-8?B?VC83NERzYW55K1ZoZ1dxcWRyNHVUalpuRlFQZjAyN2RiM1Jua1FyYk8ya2dh?=
 =?utf-8?B?YnhWbUpJMDJNTndWWk1ZdWY1a0E0d3FwZFJUNkcrR3VURzI3emtVWmVtY0tQ?=
 =?utf-8?B?VXZIbDc1Nk9mTCtzZ0FRak0vbjhRRGlaRUl5Y2p1aGx3VlVaT1RSNVB4Tjhr?=
 =?utf-8?B?Z1B6YWJuSHVNQlhIZk9CcVZKT3AzdHY0dVJ3ajY2d1kzWkV5QUNrblpBY3Q5?=
 =?utf-8?B?Ujc2ZFhRb0lEalEwS3BGQVZXejFWUmNzQXV5ejdzSzBSNjRpZHhvMWxOdWZR?=
 =?utf-8?B?N1Qvb2ExWThGeEJTWUlrZjEwaldGNEx4c1g4U0RTbjNpTlhpU1JJOE9qSUVO?=
 =?utf-8?B?UTBMM20zUkRDQlRIWWszbmhYV2NSOHFIaGhpYzdnZ2xSMVRYMDhtR0ZkRFNT?=
 =?utf-8?B?UVV4YVNNbGVtTldyMlgzWnlvMldzRklBV0VWU1oyN0VvRmswV05tTS85YUMy?=
 =?utf-8?B?RGZVVWdreXU1VEg4ZVdiVmpMN3c4NnQ2aVV4NTA1MTR0VWpSRWtEakNLQkdH?=
 =?utf-8?B?ODNyZG9Xb083QmR6SlRIOU9LaHlKczUvV2RFSGk5TDhrT3RjQjZyNldveWIr?=
 =?utf-8?B?Q2RoWXBHU1YvaWdERmxpQUNOZEZWbC9rM2ZpMDYyZWJod1NkNTMwY3hURlNN?=
 =?utf-8?B?RndLSEo4UzZZUHBFTTVONUZlMkpTbkZvVVRrRlBFK3dXNXN2OEp5M0xtME9h?=
 =?utf-8?Q?Qq5x2hiEo92YoD4Cs435qpZ6gjoTLlMxynuRTUIDBXVIa?=
x-ms-exchange-antispam-messagedata-1: 7P3jNwUu0sJNyQvFNe4FHaNtIeHuiOaG++0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A82DAB67F686A4FB525116117B5C33E@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qq71HaEilIBcQGT2hCWA/Suyj5Oo/VkzocSLFvQybA4962gGs32LasWe/pUjunHHnbfluXOhHs8Ft4ownG43CIcwWb4hiRaJNuROT/YhEZnq+W/a6TVEyFLGWQ0vSn1RpjzXGUca3SHGcrGft6pbbxSR+OhqxIF8n3913zDPtk2mfWP3SDfbvx1ZoTavCngYrGncYS/ibudazv7eYqJggk2QY8lzKVVrBQ0HqS5NtoOXZFPB20dqzTVgP3CBp7HAnbI0y+vs+/T5QqQU012HWREzQXSA0GLpuCdnvn8kTKEZAGJPCtUT2Pb6M3RRj/M2AYBXiMGsAYpq84nBMCNALw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d5a2a1-d44d-4efd-4441-08deb5b8c539
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 15:10:32.0461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQZ8P5VMZWP+1WwlUnTMRrQYPBF38EHuS+H/XMB14rbNPYGzxRCEomGZTGUF0ra8pLU/yn1ZrV8APEJpERhuBzyfuxxOn4Tdcv2yUpe4vE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2216
X-Proofpoint-GUID: oZhLDn8BEf8XGLDCF-juI_pGBFHAsG0o
X-Proofpoint-ORIG-GUID: oZhLDn8BEf8XGLDCF-juI_pGBFHAsG0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MSBTYWx0ZWRfX/QR5a6MsjLft
 pHJ2LayoRodjLxLOiHiAcSXugbJc0XN6/FDLx9ytLlXqOaKh2izFgCskWetNEYW2sSx8AzAAHm6
 5WGoF1Qu7Os+7AhbcxKrrSY69EBSWA3gU6FGrv0BHlQ/p2MblgHsiZPVZrbDlqe4MzBQBj33HQq
 8cpAm7K7fQSqzRjg5kIsuvm6xxx7/HJnt7jEekq6AYV6DwTErDnMdkGalvp0kqOTcKQrxc022D3
 g2+ogkqB6bz3zId7YiI8vBdoUl8KSKbeToHFt8Uq7GTn6HK+9Tt8oA8CJ4QkRSCEyyQnoo0UjrY
 sfk6XH+8SBli/a7JS2S0/ZH6Bmkt5xra3m7s3hAXEAQxrMFzGeuzNiDi/DkTu9HbjXueadK6kwa
 xTMbR5EdvObHYDV0n9wV+d7cUx1qRBCfHFr2wdvEKN2zNphajIUzf5TjCVS+G9r1pFYCn2td6C7
 pLg+/K5hCZmT4jCr8SQ==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0c7d6b cx=c_pps
 a=UAmMFJkMMud/O5owMpxIXA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=20KFwNOVAAAA:8
 a=r_1tXGB3AAAA:8 a=pvt_3k18FJoVCoHm5zMA:9 a=QEXdDO2ut3YA:10
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

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDE1OjEyICswMjAwLCBKYXZpZXIgTWFydGluZXogQ2FuaWxs
YXMgd3JvdGU6DQo+ICoqKiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZXMgZnJvbSBhIHNv
dXJjZSBub3Qga25vd24gdG8gSW1hZ2luYXRpb24gVGVjaG5vbG9naWVzLiBUaGluayBiZWZvcmUg
eW91IGNsaWNrIGEgbGluayBvciBvcGVuIGFuIGF0dGFjaG1lbnQgKioqDQo+IA0KPiBDb21taXQg
NDI1NzdiYTc5ZmJmICgiZHJtL2ltYWdpbmF0aW9uOiBSZW5hbWUgRlcgYm9vdGVkIHRvIEZXIGlu
aXRpYWxpc2VkIikNCj4gZHJvcHBlZCBieSBtaXN0YWtlIHRoZSBsYXN0IGFyZ3VtZW50IG9mIHRo
ZSBmdW5jdGlvbnMgcHZyX3Bvd2VyX2Z3X2VuYWJsZSgpDQo+IGFuZCBwdnJfcG93ZXJfZndfZGlz
YWJsZSgpLCBsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcgY29tcGlsZSBlcnJvcjoNCj4gDQo+ICAg
Q0MgW01dICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLm8NCj4gZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jOiBJbiBmdW5jdGlvbiDigJhwdnJfcG93
ZXJfZGV2aWNlX3N1c3BlbmTigJk6DQo+IGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
cG93ZXIuYzozODI6MjM6IGVycm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiDigJhw
dnJfcG93ZXJfZndfZGlzYWJsZeKAmTsgZXhwZWN0ZWQgMywgaGF2ZSAyDQo+ICAgMzgyIHwgICAg
ICAgICAgICAgICAgIGVyciA9IHB2cl9wb3dlcl9md19kaXNhYmxlKHB2cl9kZXYsIGZhbHNlKTsN
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4g
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9wb3dlci5jOjkzOjE6IG5vdGU6IGRlY2xh
cmVkIGhlcmUNCj4gICAgOTMgfCBwdnJfcG93ZXJfZndfZGlzYWJsZShzdHJ1Y3QgcHZyX2Rldmlj
ZSAqcHZyX2RldiwgYm9vbCBoYXJkX3Jlc2V0LCBib29sIHJwbV9zdXNwZW5kKQ0KPiAgICAgICB8
IF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
cG93ZXIuYzogSW4gZnVuY3Rpb24g4oCYcHZyX3Bvd2VyX2RldmljZV9yZXN1bWXigJk6DQo+IGRy
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcG93ZXIuYzo0MTI6MjM6IGVycm9yOiB0b28g
ZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiDigJhwdnJfcG93ZXJfZndfZW5hYmxl4oCZOyBleHBl
Y3RlZCAyLCBoYXZlIDENCj4gICA0MTIgfCAgICAgICAgICAgICAgICAgZXJyID0gcHZyX3Bvd2Vy
X2Z3X2VuYWJsZShwdnJfZGV2KTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2Vy
LmM6MTIyOjE6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gICAxMjIgfCBwdnJfcG93ZXJfZndfZW5h
YmxlKHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LCBib29sIHJwbV9yZXN1bWUpDQo+ICAgICAg
IHwgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBtYWtlWzZdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUu
YnVpbGQ6Mjg5OiBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLm9dIEVycm9y
IDENCj4gbWFrZVs1XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjU0ODogZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uXSBFcnJvciAyDQo+IG1ha2VbNF06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDo1NDg6IGRyaXZlcnMvZ3B1L2RybV0gRXJyb3IgMg0KPiBtYWtlWzNdOiAqKiog
W3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTQ4OiBkcml2ZXJzL2dwdV0gRXJyb3IgMg0KPiBtYWtl
WzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTQ4OiBkcml2ZXJzXSBFcnJvciAyDQo+
IG1ha2VbMV06ICoqKiBbL2hvbWUvamF2aWVyL2RldmVsL2xpbnV4L01ha2VmaWxlOjIxNDE6IC5d
IEVycm9yIDINCj4gbWFrZTogKioqIFtNYWtlZmlsZToyNDg6IF9fc3ViLW1ha2VdIEVycm9yIDIN
Cj4gDQo+IEZpeGVzOiA0MjU3N2JhNzlmYmYgKCJkcm0vaW1hZ2luYXRpb246IFJlbmFtZSBGVyBi
b290ZWQgdG8gRlcgaW5pdGlhbGlzZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgTWFydGlu
ZXogQ2FuaWxsYXMgPGphdmllcm1AcmVkaGF0LmNvbT4NCj4gLS0tDQo+IA0KPiANCj4gIGRyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcG93ZXIuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMgYi9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMNCj4gaW5kZXggMGVkOWU3YmU2MDRiLi5hNzFkNWIz
NTYwMWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfcG93
ZXIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3Bvd2VyLmMNCj4g
QEAgLTM3OSw3ICszNzksNyBAQCBwdnJfcG93ZXJfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gIA0KPiAgCWlmIChSRUFEX09OQ0UocHZyX2Rl
di0+ZndfZGV2LmluaXRpYWxpc2VkKSkgew0KPiAtCQllcnIgPSBwdnJfcG93ZXJfZndfZGlzYWJs
ZShwdnJfZGV2LCBmYWxzZSk7DQo+ICsJCWVyciA9IHB2cl9wb3dlcl9md19kaXNhYmxlKHB2cl9k
ZXYsIGZhbHNlLCB0cnVlKTsNCj4gIAkJaWYgKGVycikNCj4gIAkJCWdvdG8gZXJyX2RybV9kZXZf
ZXhpdDsNCj4gIAl9DQo+IEBAIC00MDksNyArNDA5LDcgQEAgcHZyX3Bvd2VyX2RldmljZV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCQlnb3RvIGVycl9kcm1fZGV2X2V4aXQ7DQo+ICAN
Cj4gIAlpZiAoUkVBRF9PTkNFKHB2cl9kZXYtPmZ3X2Rldi5pbml0aWFsaXNlZCkpIHsNCj4gLQkJ
ZXJyID0gcHZyX3Bvd2VyX2Z3X2VuYWJsZShwdnJfZGV2KTsNCj4gKwkJZXJyID0gcHZyX3Bvd2Vy
X2Z3X2VuYWJsZShwdnJfZGV2LCB0cnVlKTsNCj4gIAkJaWYgKGVycikNCj4gIAkJCWdvdG8gZXJy
X3Bvd2VyX29mZjsNCj4gIAl9DQoNClJldmlld2VkLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNo
Lmd1cHRhQGltZ3RlYy5jb20+DQo=
