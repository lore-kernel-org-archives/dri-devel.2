Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5ACC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F67B10E3B7;
	Mon,  6 Jul 2026 16:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ilcJZzKn";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="KMH/71MV";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A1A10E3B7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 16:19:05 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FFM8a585293; Mon, 6 Jul 2026 17:18:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=hDN4qMXqLbTj28p8dYnANJuitUVqvN2FEy1zIjA7jgU=; b=ilc
 JZzKnT4Mc8mPw4RwLyfDQQavsJOGEJ+F9jmUj8w4icsUKnXJsy8qGBi7H7/XOKZo
 9vxiVrG5MUiikTWwTc7Hll7JexsxipLD3+9xwQEGtI4KmaDeBgfW7xV7ahPs7BRM
 +B2zLwvsS2Pg/4wb576TnWwz188Dm8rLqmhU2uUcnw+lRT9f9lg1z+0n5C8b+7NT
 WwviicbTWe8jA+O4zJ0e27GdDtSDmSIgOqs0a1f0NXvAnpet0UBLdgNIuQToL7EL
 mZsS1t4FCpEBuzuOJKGy27LKkzKTPzyiK94cRerabw5sRXl/nanalxTB6NuFtd9b
 Dr8WpTPNz1u82gR6eXQ==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021133.outbound.protection.outlook.com [52.101.95.133])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f6t8tsxry-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 17:18:42 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shne4sC3mgIZnmg1k6m12uZVEXv3liL5SsVK8HT/NKWSYkxCbXUAfOMfNRPcL3HrJYpz5iLMwgOx8sYDunnmexK0NbEBJHLD8u/3P4UL3UEwCZyu9YsidPAO6mielrY7PVs+DoW5rZ44La2Duy+m6nSzXZAu73utq/LF5xZRkeXwPYsaCat8DkBGzYvFpUIRg/ch3mBIR+eMpDA9b6aJY7du9/9VRDQ18g2UYTq0cLHQcq9+WSNoAI/SU2tqGDTmdE0DRcmvUQDFw/8girffZablXMJbODCvy1iW/g0UNBMe9qzLXgqSQFSnn+bLX2UChH+NxXiffJvk7YNcTMhjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDN4qMXqLbTj28p8dYnANJuitUVqvN2FEy1zIjA7jgU=;
 b=aPGCOf17/2M3rWEUYCqAfk9aCSyITg4VMM2aZZPy+3UlsyAmaCO2iBL8AkdMI0MlXpbx5Eck18dYFSBgLjEyMAkAYnx9U2J3Jsxu3TCgm+4l7yz/Y5dr+WfRU/aZByHPGuT5VaDl9FuVEjQ4H28ZgG/4j5dd0tWKrDIcfY2sX6omuk36gM5fQx1w2kUA7BOEAjlO60xtZxxCyid52Rf2NA+1WBxhi0/I0fMI0xFPY8nnM+sJ9LF8K0Bi1JIHYE2lRqOpx6Sa5aLPMIw8KSzaLfFWxJheysskHtBzc3ecopwQTGZh9tqlR9nl8hqpKf755+KwhXmArT54hnivF0r9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDN4qMXqLbTj28p8dYnANJuitUVqvN2FEy1zIjA7jgU=;
 b=KMH/71MV6hJtRdIM2gYmodXMzAWOG/roqITnhXnlUP+ne76BC931uFWEWy4Bs5k/aH4qXvnx+E6XaVLsnzQPQTcd389P6TIydD4c2srnTiqYJHct0PU5192wCe1GYcFre6RwuN2egiS0ltoWnh6zCFE3dzOzgZI5DIySq2lcY3k=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB1972.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 16:18:39 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 16:18:39 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Topic: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Index: AQHdAv6cDuELNuAwok2enfCCyEYJ8bZcDdWAgASyYIA=
Date: Mon, 6 Jul 2026 16:18:38 +0000
Message-ID: <79b9d7bda6e0fd9318abf465031e47e358411a41.camel@imgtec.com>
References: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
 <b2c5ea38-bb7f-47c8-93ce-db15b66d0e58@codethink.co.uk>
In-Reply-To: <b2c5ea38-bb7f-47c8-93ce-db15b66d0e58@codethink.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB1972:EE_
x-ms-office365-filtering-correlation-id: 6aa58a57-313b-4f79-a424-08dedb7a3cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003;
x-microsoft-antispam-message-info: 8QUPbm8IDTkqINfNS/rn1s1TAKeMJXWwBnaw7vg3sN3gzQ21Gv3gVj77J0wFhOFIh58/0EMvOMJwKzHmgz2S+zhNK0nkTyc3Wt4psdWeCmfjWlxr5t78t+FmvhSBoBV6Jijb6yU0t1YmQr0U7O9gS2S7RfWXBNOr9WIqFT5WvdHQAoHFHtV4THY4VuT4sBD/EA7WmE4ZVyDUxxJU5Hueoh/6QEWeQMNQXM+hET3JL1LuWGSh/0t+O7v9UP5uaqKQPl/4PRT1aOw1OOJC+UsYF7/hsrucZHua0N2RskC1X0iLFl+U4NdmDurZdRwJy8GTje8AKxgLoIPOwKOftlHHTZKn3n8eMCyhm9DQYgevY3HgVsGGgxClSe6pbBUThlIe614VuPONKwaM7nZEhsSFz2KUk6+4V0EUJoi1srOENXyPI+HJ9p2vWxLVdjn0k2mw7Dn6A5LCfeLz1dfjv7hKaUDlw9Qf0xprTtSAN5jKbwXBfw7HJaRf2jH+AugIsvt56sxWezME6iMKp8spuIZch3Y1fHAGw+dza/W62RhTBy+anbKP3fn1zMj1EOMVAbpzsfHMTxyN/tYE62klnxmBURyUlirjMUECew96hTVd1jZxzYBjCQj6Z7Sg7nC3793ZEjhm052Q+Zbw8WjW29yyclD4+2ez+pmkVBHz6+QQbg3nE26D3u9vs2KLl2ef1NdpW5woGENeGdUz5Nr90L/JZ1+DzBAa5ijCEhUHvLfHnDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdmQTB6dVE1bmkweDRuelNEd20wd1ZVdWhNZ0VzUENRTXNxalplbFMrOExs?=
 =?utf-8?B?dDdrRXhzdWVQejZQQnhHbU9TU2JMZzcvUjJQdHhiRWMrMkhieEt3dHIweG5P?=
 =?utf-8?B?WkNuS01oeU5JK0NGQVEyWGc1NUtETUlrbDBZWFZkanB5Qm1nekZXTElqYkdR?=
 =?utf-8?B?eVJENzdwbFlIZEUvbjB3SzkvM2QyQUhwQ25oSUNtdU8rakh0aWh6dE1JM3FD?=
 =?utf-8?B?a2VSSllwU015cnhxTW11ZUZvcEdOejdubm8xRHJ4VS9EZVVrNnJiMkY4RUoz?=
 =?utf-8?B?US9EaE12Y1JkOEljZzl0YVY3WVoyWEtWUjh0Vk5oRzJYL2QvazRlR090UEVl?=
 =?utf-8?B?cEVMdXBUNEFhS3FmemhCK1ZydWRJek0rM3Jzb2g4OE1Ba2FNV1duRDJLZmoy?=
 =?utf-8?B?NW5xU3p3VmxnMStPcWdKNExaUHNhOUFuMXYxeXk4RkluaStsbE9xSHB0VUVh?=
 =?utf-8?B?YlhuY09vVVhaMXNYb2hycjE0RW4zZjdrTlR3OUFzck81ZDFVOElRRFgra0dE?=
 =?utf-8?B?c3YrK3pkUFpZb0NrRWcvQXh0STBMZnNRU0l5aUhGWnVBNS92UWphRk15VlA3?=
 =?utf-8?B?a3RBdFV3SUwwZTkvZExnVUVZNjFzVTZHRG9sTG5OYkxjZUZvbTJnUmhFZlE2?=
 =?utf-8?B?c3l0dFlVeGhSUGtPRTluMVgwYkM0RG5mSnc4UEljbEJSS09xeTh4YTF2eWlk?=
 =?utf-8?B?NUV1ckwrV0FVck5FbzVJYVpTQ1Aya24rdUdvUlBrOU9ZdnU0R1krZGljK1d1?=
 =?utf-8?B?S1dncUNDYm95USs0aXo5ZHpid0xMM0NycS9jNVJlWmJHMitkWlRuMnNpa0hF?=
 =?utf-8?B?MlhkeiswajBVeU50UUdGRVRXaDlTWldBOThLMkhxNWNzR21zZU4vRE0xYUNW?=
 =?utf-8?B?NUFqMjk5RitrZFpzckh1ei9LV2o4MzhVL1d0UEFaV0NkK2FMWndOK0Y4RDBF?=
 =?utf-8?B?S3MxbEZjRGk5WmpGbDlDY0FRbzYzS1FSZURrenJHdU5FUi9xM1I0ekJEbW9t?=
 =?utf-8?B?ZUJLdk1sVlM4REJ5TEczNCtiY3dvNks5RWRtZEtQd1hscTVpZ2JuN0YydU5O?=
 =?utf-8?B?Q0tRL1J1ZllEb1lhTTI2SEJNaVlkU2EzUy9VckYxeWxzRENHSy9vQVVBYXZY?=
 =?utf-8?B?RG1mNzROVWNVOXNvWG1UbFFLVk5BSEhDQVNTVis3cG51cEpBeDJOZ3FLWUdS?=
 =?utf-8?B?K1pnL2lqZERZUDNUWUpFajlvRFFGeE1iK3M5T0pzT0FyOTExMzQ5UXJzdG9i?=
 =?utf-8?B?dmdJQm1BMXZ5MWljVCtiVnFWK3dLVHBqYndIVEd6cTZBb0NCbWN2WjJMSFhC?=
 =?utf-8?B?Q2p3SDdaT3VxNzczbUFCM2UvNWlyR21SLy9QcU03bk9aNWw5RklnQ2pPNk14?=
 =?utf-8?B?SjhRQUpQK0tocXo2YVBqMUR2K3NSd2Q5cWxsTkxveWcrZHh4VzhsTFkrV2Nm?=
 =?utf-8?B?K1BXTTdqNlVSOUZqNXEvZ2dlTW5xSVg3eVEzK1BCMmJ4T3FWaGFjVzFPc0tw?=
 =?utf-8?B?enU5SUJOMjdyYmV1c2FJV2RxMTJoZ2huTmszeURieWlaOVhlQ1k5bnMvN0pu?=
 =?utf-8?B?U0Q0WndzUjlFVWlzK01qaDE2RHMwSTZ4U1A4OG9DZ2RiSVczV3hQekNVclJs?=
 =?utf-8?B?aFhRLzl6bUtKREcvbXNxTm9TblRMaW8xOCs0UHVnejJ2czBXL0kzU3htUWRO?=
 =?utf-8?B?Z3M1eUlnZklGRkU3b1NYZHg1VUFEbHVCbWl3ZXUzU21Nek1WTGJhN1N2WER3?=
 =?utf-8?B?dUJYWWN3NGs0YTlNd3NpM256cTJZVXVOeVM2WC80Zm5RNlFGZTlDMFNYOFZK?=
 =?utf-8?B?Q0RYdEhTLzV5ZmZzOFRSUVpJR2ZuejdWNFJGY08xdGJocVJUODlFMk1sTmNF?=
 =?utf-8?B?K0xIaThoLzhLMlFocXN2QVc5RkU3UWt4TzBZeGlUMGkxWWMrNVVFMElUbWZs?=
 =?utf-8?B?SHlQNFdpbzBMbExRK2tYRWs2cG1zMG9GMXNtakpXeUkyU0luTEdpWkgzT0lz?=
 =?utf-8?B?SzZwUlZQbjBYc3YyQW01aFUwUmV1ZUVjZkZreHhqdzdqeWRQVnNIQ2tiT1pr?=
 =?utf-8?B?S1g5eTdxMXRMVDRFQ0Fuei9EbERpZ3ZDTGY3VThLYS9iaVJESktBcVBIZUJq?=
 =?utf-8?B?STJuSVQ5dWtEQkJWZFhKOXBNMmlNNHE2TDQ1WU1GWXB6aUZOVzNxTCt6bVFv?=
 =?utf-8?B?QVdIUVVMc2NUa0V3bWZVdHJWOXFjdXBIemJYaUZwa0Z0TFFTa0Nob2M2eWdF?=
 =?utf-8?B?dDA5RjFZZ1VTUmozQzdNd0pBSlIxN0NwUzRFVUFqMFNsMXNLWW1yK2QzNGRa?=
 =?utf-8?B?VnhucWVkSFJkU2hNeGxTZ0ZkOFNycHJydWJURkRGNm5CelpuMlJ3ZVNLWE5i?=
 =?utf-8?Q?Lkh+DIawekZytmh0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1740853BACB4048BE2736D54114B375@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hxtXW+QAK/VdvOK+3hiKsbu88XzEEUXMnAH4dNpyAh2MDURWZIYgA1jWh8izxCprraTfgW2Dq+tEa+hamhS0BNWwgG9t4wRnwP1gXV6DSuDm9sszHw47m4LwNv13ktrtZ/aTGxBRcFeKWRl+57QUodl4SjKVB5Y29XpYP04tKgAd8HtPBEmU35TV+dlRA29zWHFWX84h0f1ylSbF39oVLPPv6aXq9WSholxlt8RPx/Z+4GZ/eDy7YNhFPa+K5lbRB1/C2BxcGw6b83gH/r4TDIvMdzhr2rWORHZNcATXTwt24XOjDPF34JsV2o6n85oacwDPLkbcNNtsY0JKErVFdA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa58a57-313b-4f79-a424-08dedb7a3cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 16:18:38.6378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gJlJn2TfpYmhh8YNeWwMUquY2esPBXG2JDheHTjqAsiPU2pQNxQdiCFA9PfheZqTHBTNaFhvC7cy6OPs+cqX2f/Ttq+jv2/6288AxLPmeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB1972
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a4bd562 cx=c_pps
 a=bKiAksUUuG6HAO+OrEcI0A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=44dMrQcG-JvUqhCc1sMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 90OrZHdzI1dXuflA2KOehowt_2NgQ1Qb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX6ykBGsOg3tem
 pzCo1sFdNoUIrN3Ajzne7x6FIHIxFvhxSQ6Sh6kcYL+xVh0CgT9EDalceN735As+yobCgcKnWEl
 sq+Ie9rxYwsLZdNlaQh/8DpFe+jg+Xk=
X-Proofpoint-GUID: 90OrZHdzI1dXuflA2KOehowt_2NgQ1Qb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX37SRomEbTbLa
 0yzHV0fb9XIHhWu8FZ9SNMPmNBHLh0vgQWyxEj/c3u7XZ7YqJzlgUhjHT+5bJ+4FokjRZqrXPCX
 hjnzU/8wO4l7DttnwHt/1oqUCvOpNYN4lMPjTTuV8RfIdWx4Cvbw7n0p7nUibPk0CxT1eDXw7U8
 fZx+b/1/wsGggyKb32EGGYtrW5wkD42fmQ4DRv8jhdyCheXAukubbjwQRQEnh92uCrXxURkKQq1
 rj0NsTsw8xzn4g9xsIPXMeCQ7jid8JAl5n9cqQk5BlWnY4TT9dBQY0gSB4dBk12Dpr11+fBcHZ5
 tV/FcGzVnh7XzDu1z7mcO9J7z0ueHFOArZHv6D6ZONHZtRv/O4VvjZW7ThfP57nYPtKe3jzUkN4
 eygTyp2xcUNcs7YMOgsufXJbasHI6V+hiuGj48RRYdjd3gQQqxHnw7WErXKukSt9T8gAb0JdBN8
 piFmYKMK4gKpKfcuWCw==
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

SGkgQmVuLA0KDQpPbiBGcmksIDIwMjYtMDctMDMgYXQgMTc6MzUgKzAxMDAsIEJlbiBEb29rcyB3
cm90ZToNCj4gT24gMjMvMDYvMjAyNiAxMTo1MywgQmVuIERvb2tzIHdyb3RlOg0KPiA+IFRoZSBw
dnJfZndfdHJhY2VfaW5pdF9tYXNrX29wcyBpcyBub3QgdXNlZCBvdXRzaWRlIHB2cl9md190cmFj
ZS5jDQo+ID4gc28gbWFrZSBpdCBzdGF0aWMgdG8gYXZvaWQgdGhlIGZvbGxvd2luZyBzcGFyc2Ug
d2FybmluZzoNCj4gPiANCj4gPiBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3Ry
YWNlLmM6NzQ6MzE6IHdhcm5pbmc6IHN5bWJvbCAncHZyX2Z3X3RyYWNlX2luaXRfbWFza19vcHMn
IHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+ID4gDQo+IA0KPiBGWUkg
dGhlIE1hdHQuQ29zdGVyQGltZ3RlYy5jb20gaXMgcmVwb3J0aW5nIHJlY2lwaWVudCBmYWlsdXJl
Lg0KPiANCj4gRG9lcyB0aGlzIG5lZWQgY2hhbmdpbmcgb3IgcmVtb3Zpbmc/DQo+IA0KDQpNYXR0
IGhhcyAodW5mb3J0dW5hdGVseSBmb3IgdXMpIGxlZnQgSW1hZ2luYXRpb24gdmVyeSByZWNlbnRs
eS4gTWFpbnRhaW5lcnMgbGlzdA0KYW5kIG1haWxtYXAgaGF2ZSBiZWVuIHVwZGF0ZWQgb24gZHJt
LW1pc2MtbmV4dCwgc28gb25jZSB0aG9zZSBjaGFuZ2VzIGhhdmUNCnByb3BhZ2F0ZWQgdGhpcyBz
aG91bGQgc29ydCBpdHNlbGYgZm9yIG5ldyBwYXRjaCBzZXJpZXMgYXQgbGVhc3QuDQoNClRoYW5r
cywNCkFsZXNzaW8NCg==
